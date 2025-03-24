import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/core/global/custom_button.dart';
import 'package:yuvaprabha/core/global/custom_text_field.dart';
import 'package:yuvaprabha/core/provider/resume_data_provider.dart';

import '../../../../config/api/export.dart';
import '../../../../core/global/custom_snack.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeData = Provider.of<ResumeDataProvider>(context);

    final TextEditingController skillsController =
        TextEditingController(text: resumeData.skills.join(','));
    final TextEditingController courseworkController =
        TextEditingController(text: resumeData.courses.join(','));
    return Column(
      children: [
        Text(
          'Skills & Coursework',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        h16,
        CustomTextField(
          controller: skillsController,
          hint: "Skills (comma-separated)",
        ),
        h12,
        CustomTextField(
          controller: courseworkController,
          hint: "Coursework (comma-separated)",
        ),
        h12,
        CustomElevatedButton(
          ontap: () {
            resumeData.updateSkills(skillsController.text);
            resumeData.updateCoursework(courseworkController.text);
            ScaffoldMessenger.of(context).showSnackBar(showSnack());
          },
          text: "Save",
        ),
      ],
    );
  }
}
