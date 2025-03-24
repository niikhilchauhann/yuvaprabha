import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/api/export.dart';
import 'package:http/http.dart' as http;

class PDFViewerScreen extends StatefulWidget {
  final String text;
  final String desc;
  final String pdfUrl;

  const PDFViewerScreen(
      {super.key,
      required this.pdfUrl,
      required this.text,
      required this.desc});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    downloadPDF(widget.pdfUrl);
  }

  Future<void> downloadPDF(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/temp.pdf');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localFilePath = file.path;
        });
      } else {
        print("Failed to load PDF: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: localFilePath == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h16,
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  h4,
                  Text(
                    widget.desc,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  h16,
                  Expanded(
                    child: PDFView(
                      filePath: localFilePath!,
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: true,
                      pageFling: true,
                      
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ).px(16),
            ),
    );
  }
}
