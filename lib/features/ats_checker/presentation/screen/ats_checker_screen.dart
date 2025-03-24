import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:yuvaprabha/config/api/export.dart';
import 'dart:io';

import 'package:yuvaprabha/core/constants/secrets.dart';
import 'package:yuvaprabha/core/global/custom_route.dart';
import 'package:yuvaprabha/core/global/custom_text_field.dart';
import 'package:yuvaprabha/features/ats_checker/presentation/screen/result_screen.dart';

class AtsCheckerScreen extends StatefulWidget {
  const AtsCheckerScreen({super.key});

  @override
  State<AtsCheckerScreen> createState() => _AtsCheckerScreenState();
}

class _AtsCheckerScreenState extends State<AtsCheckerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _initializeModel();
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  String extractedText = '';
  bool isLoading = false;
  String atsResults = '';

  Future<void> pickAndProcessFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      File file = File(result.files.single.path!);
      await extractTextFromPdf(file);
    }
  }

  Future<void> extractTextFromPdf(File file) async {
    setState(() => isLoading = true);
    try {
      final PDFDoc extractor = await PDFDoc.fromFile(file);
      String extractedText = await extractor.text;
      setState(() => this.extractedText = extractedText);
    } catch (e) {
      setState(() => extractedText = "Error extracting text: $e");
    }
    setState(() => isLoading = false);
  }

  Future<void> _initializeModel() async {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      generationConfig: GenerationConfig(temperature: 0.7),
    );
  }

  late GenerativeModel _model;

  _sendToGemini(String text) async {
    setState(() {
      isLoading = true;
    });
    final prompt = """
    Analyze the following resume text and the job description that I am applying for, give me valuable feedback based on these ATS checks:
    
    1. Repetition of words and phrases
    2. Spelling and grammar errors
    3. Quantifying impact in experience section
    4. Bullet points length with shortening suggestions
    5. Hard skills matching the job role
    6. Soft skills inclusion
    7. Presence of essential sections (Contact, Experience, Skills, Education, Summary)
    8. Personality showcase with improvement tips
    9. Professional email address usage
    10. Usage of active voice and action verbs
    11. Presence of buzzwords and clichés
    12. Overall ATS score (0-100) with improvement suggestions
    

    Job Description:
    ${_jobDesc.text}

    Resume Text:
    $text
    
    Provide detailed feedback with an ATS score and actionable suggestions. Do not bold the text, just give plain answer. Give ATS score first then give the points. Also include examples whereever possible like:

      Good example

        Achieved 40% product revenue growth in three months by planning and launching four new key features.

        Improved state test pass rates from 78% to 87% in two years.

      Bad examples

        Created a conducive learning environment.

        Responsible for preparing financial reports including budget performance.

      Keep the answer short and sweet. Keep it well Structured using tabs and spaces. 

    """;
    try {
      final content = <Content>[];
      content.add(Content.text(prompt));
      final response = await _model.generateContent(content);
      setState(() => isLoading = false);

      return response.text.toString();
    } catch (e) {
      print('Error sending to Gemini: $e');
    }
  }

  final TextEditingController _jobDesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h24,
                Column(
                  children: [
                    Text(
                      'Resume Analyzer',
                      style: TextStyle(
                          color: primary, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    h12,
                    Text(
                      'Is your resume good enough?',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                    h16,
                    Text(
                      'A free and fast AI resume checker doing 12+ crucial checks to ensure your resume is ready to perform and get you interview callbacks.',
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    Lottie.asset(
                      'assets/resume_upload.json',
                      height: 300,
                      width: 300,
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                        _controller.repeat();
                      },
                      repeat: true,
                      frameRate: FrameRate.max,
                    ),
                    ElevatedButton.icon(
                      onPressed: pickAndProcessFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(Icons.upload_file, color: Colors.white),
                      label: Text('Upload Your Resume',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                  ],
                ).px(32),
                h24,
                h16,
                Text('Job Description:',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                h8,
                CustomTextField(
                    isPara: true,
                    hint:
                        "Enter the job's description for which you're applying along with some company details.",
                    controller: _jobDesc),
                h4,
                Text('Extracted Text:',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                h8,
                Container(
                  padding: EdgeInsets.all(10),
                  height: 120,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      extractedText == ''
                          ? 'Upload your resume to see parsed text.'
                          : extractedText,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                h32,
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_jobDesc.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: Text('Error'),
                            content: Text('Please fill in job details.'),
                          ),
                        );
                      } else {
                        final String response =
                            await _sendToGemini(extractedText);
                        setState(() {
                          isLoading = false;
                        });
                        if (mounted) {
                          Navigator.push(context,
                              createRoute(ResultScreen(result: response)));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(Icons.done_all_rounded, color: Colors.white),
                    label: Text('Submit Resume',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
                h32
              ],
            ).p(16),
          ),
          if (isLoading)
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.black12,
              child: Center(
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: CircularProgressIndicator(
                      strokeWidth: 3.2,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
