import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/api/export.dart';
import '../../../../core/global/custom_round_button.dart';
import '../../../../core/provider/resume_data_provider.dart';
import '../../../../core/provider/theme_provider.dart';

class ResumeAppBar extends StatelessWidget {
  final int id;
  const ResumeAppBar({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: isDark ? surfaceDark : surface,
      child: Row(
        children: [
          CustomRoundButton(
            onPressed: () {
              Navigator.pop(context);
            },
            size: 11,
            color: Colors.black,
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            ),
          ),
          w16,
          Text(
            "Resume No. 1",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              CupertinoIcons.cloud_download,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () async {
              final resumeData =
                  Provider.of<ResumeDataProvider>(context, listen: false);
              await ResumePdfGenerator.generateAndShowPdf(resumeData, id);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
