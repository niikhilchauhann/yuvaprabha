import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:uuid/uuid.dart';
import 'package:yuvaprabha/providers/theme_provider.dart';

import '../../utils/core/export.dart';

class ChatPage extends StatefulWidget {
  final bool? newChat;
  final bool imageSearch;
  const ChatPage({super.key, this.newChat, required this.imageSearch});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: 'user-1', firstName: 'User');
  final _bot = const types.User(id: 'bot-1', firstName: 'Yuvaprabha');
  late GenerativeModel _model;
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  List<types.User> _typing = [];
  bool _isListening = false;
  bool _isSpeaking = false; // For speaking indicator
  dynamic selectedImage;

  @override
  void initState() {
    super.initState();
    _initializeModel();

    if (widget.newChat == true) {
      _createNewChatFile();
    } else {
      loadMessages().then((loadedMessages) {
        setState(() {
          _messages = loadedMessages;
        });
      });
    }
  }

  Future<void> _createNewChatFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/messages.json');

      if (await file.exists()) {
        await file.delete(); // Remove old file
      }

      // Create an empty file for new chat
      await file.writeAsString(jsonEncode([]));
      setState(() {
        _messages = [];
      });
    } catch (e) {
      print('Error creating new chat file: $e');
    }
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    // Prepare content for Gemini
    final content = <Content>[];
    if (selectedImage != null) {
      content.add(Content.multi(
          [TextPart(message.text), DataPart('image/jpeg', selectedImage)]));
    } else {
      content.add(Content.text(message.text));
    }

    setState(() {
      _typing = [_bot];
    });

    _sendToGemini(content);
    saveMessages(_messages);
    selectedImage = null; // Reset selected image after sending
  }

  Future<void> _sendToGemini(List<Content> content) async {
    try {
      final response = await _model.generateContent(content);

      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: response.text.toString(),
      );

      _addMessage(botMessage);
      saveMessages(_messages);
    } catch (e) {
      print('Error sending to Gemini: $e');
    }
  }

  Future<void> _handleVoiceInput() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(onResult: (result) async {
          if (result.finalResult) {
            final input = result.recognizedWords;
            setState(() => _isListening = false);

            setState(() => _isSpeaking = true);
            await _speakResponse(input);
          }
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _isSpeaking = false;
      });
      _speechToText.stop();
    }
  }

  Future<void> _speakResponse(String input) async {
    try {
      final response = await _model.generateContent([Content.text(input)]);
      await _flutterTts.speak(response.text.toString());
      _flutterTts.setCompletionHandler(
        () => setState(() => _isSpeaking = false),
      );
    } catch (e) {
      print('Error in speech response: $e');
    }
  }

  bool imageUploading = false;
  void _handleImageSelection() async {
    setState(() {
      imageUploading = true;
    });
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final imageMessage = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: 1440,
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: 1440,
      );

      selectedImage = bytes;
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      imageUploading = false;
                    });
                  },
                  child: Text('Okay'))
            ],
            title: Text('Image Uploaded'),
            content: Text(
                'Image has been uploaded successfully, add a text message to get response.'),
          ),
        );
      }
      _addMessage(imageMessage);
    }
  }

  Future<void> saveMessages(List<types.Message> messages) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/messages.json');

      final messagesJson = messages.map((msg) => msg.toJson()).toList();
      await file.writeAsString(jsonEncode(messagesJson));
    } catch (e) {
      print('Error saving messages: $e');
    }
  }

  Future<List<types.Message>> loadMessages() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/messages.json');

      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> messagesJson = jsonDecode(content);

        return messagesJson
            .map((msg) => types.Message.fromJson(msg as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error loading messages: $e');
    }

    return [];
  }

  Future<void> _initializeModel() async {
    final apiKey = 'AIzaSyDAPaCTA54yWWk4I7m1tRY2iUvUX2yPf5k';
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      generationConfig: GenerationConfig(temperature: 0.7),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
      _typing = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final List<Color> kDefaultRainbowColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
    return Scaffold(
      backgroundColor: surfaceDark,
      appBar: AppBar(
        title: Text('Chat with YuvaprabhaAI'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppConstants.defPadInner),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_isSpeaking)
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: LoadingIndicator(
                          colors: kDefaultRainbowColors,
                          indicatorType: Indicator.lineScaleParty,
                        ),
                      ),
                    ),
                  if (_isListening)
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: LoadingIndicator(
                          colors: kDefaultRainbowColors,
                          indicatorType: Indicator.ballPulseSync,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      _isListening
                          ? CupertinoIcons.mic
                          : CupertinoIcons.mic_off,
                      color: _isListening ? Colors.blue : Colors.grey.shade400,
                      size: _isListening ? 28 : 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSpeaking = false;
                      });
                      _handleVoiceInput();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: chat_ui.Chat(
                audioMessageBuilder: (context, {required messageWidth}) {
                  return SizedBox(
                    width: messageWidth * 1.0,
                    child: Icon(Icons.audiotrack),
                  );
                },
                typingIndicatorOptions:
                    chat_ui.TypingIndicatorOptions(typingUsers: _typing),
                messages: _messages,
                isAttachmentUploading: imageUploading,
                onAttachmentPressed:
                    widget.imageSearch ? _handleImageSelection : null,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                user: _user,
                theme: isDark
                    ? chat_ui.DarkChatTheme()
                    : chat_ui.DefaultChatTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
