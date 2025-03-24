import 'package:flutter/material.dart';

import '../../../../config/api/export.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Checker'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h24,
              Text(
                "Here's your result: ",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w900, height: 1.2),
              ),
              h16,
              Text(
                result,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ).px(24),
        ),
      ),
    );
  }
}
