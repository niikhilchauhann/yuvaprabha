import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/config/api/export.dart';
import 'package:yuvaprabha/core/provider/theme_provider.dart';

import '../data/resume_data.dart';
import 'pdf_view_screen.dart';

class RoadmapsScreen extends StatelessWidget {
  const RoadmapsScreen({super.key});

  final String baseUrl =
      "https://raw.githubusercontent.com/niikhilchauhann/roadmaps/master/public/pdfs/roadmaps";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Roadmaps',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h16,
              Text(
                'Developer Roadmaps',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              h4,
              Text(
                "Browse ever-growing list of 100% free roadmaps, lifetime updatation – yes really.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              h16,
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Request for a roadmap',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              h8,
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Generate Roadmaps with AI',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              h16,
              Text(
                'ROLE BASED ROADMAPS',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              h8,
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: roadmapsVer2
                    .map(
                      (map) => _roadmapCard(
                        context,
                        title: map['title']!,
                        desc: map['desc']!,
                        url: '$baseUrl/${map['file']}',
                      ),
                    )
                    .toList(),
              ),
            ],
          ).px(16),
        ),
      ),
    );
  }

  Widget _roadmapCard(BuildContext context,
      {required String url, required String title, required String desc}) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PDFViewerScreen(
              pdfUrl: url,
              text: title,
              desc: desc,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(5),
      child: Ink(
        decoration: BoxDecoration(
          color: isDark ? surfaceDark : surface,
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 2), color: Colors.black26, blurRadius: 4)
          ],
          border: Border.all(
              color: isDark ? Colors.transparent : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ).pOnly(bottom: 8);
  }
}
