import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/api/export.dart';
import '../../../../core/constants/regex_constants.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_date_picker.dart';
import '../../../../core/global/custom_snack.dart';
import '../../../../core/global/custom_text_field.dart';
import '../../../../core/provider/resume_data_provider.dart';

class EducationPage extends StatelessWidget {
  EducationPage({super.key});

  final FocusNode aNode = FocusNode();
  final FocusNode bNode = FocusNode();
  final FocusNode cNode = FocusNode();

  DateTime? startPicked;
  DateTime? endPicked;

  @override
  Widget build(BuildContext context) {
    final resumeData = Provider.of<ResumeDataProvider>(context);

    final TextEditingController degreeController = TextEditingController(
        text: resumeData.education.isNotEmpty
            ? resumeData.education.first['degree'].toString()
            : '');
    final TextEditingController collegeController = TextEditingController(
        text: resumeData.education.isNotEmpty
            ? resumeData.education.first['college'].toString()
            : '');
    final TextEditingController startController = TextEditingController(
        text: resumeData.education.isNotEmpty
            ? resumeData.education.first['start'].toString()
            : '');
    final TextEditingController endController = TextEditingController(
        text: resumeData.education.isNotEmpty
            ? resumeData.education.first['end'].toString()
            : '');
    final TextEditingController descController = TextEditingController(
        text: resumeData.education.isNotEmpty
            ? resumeData.education.first['description'].toString()
            : '');

    return Column(
      children: [
        Text(
          'Education Details',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        h16,
        CustomTextField(
          hint: 'Degree Name',
          controller: degreeController,
          focusNode: aNode,
          nextFocus: bNode,
        ),
        CustomTextField(
          hint: 'College/School Name',
          controller: collegeController,
          focusNode: bNode,
          nextFocus: cNode,
        ),
        Row(
          children: [
            Expanded(
              child: CustomDatePicker(
                ontap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    startPicked = picked;
                    startController.text = dateFormat
                        .format(picked); // ✅ Format date before assigning
                  }
                },
                text: 'Start Date',
                date:
                    startController.text.isEmpty ? null : startController.text,
              ),
            ),
            w16,
            Expanded(
              child: CustomDatePicker(
                ontap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    endPicked = picked;
                    endController.text = dateFormat.format(picked);
                  }
                },
                text: 'End Date',
                date: endController.text.isEmpty ? null : endController.text,
              ),
            ),
          ],
        ),
        CustomTextField(
          hint: 'Description',
          controller: descController,
          focusNode: cNode,
        ),
        h12,
        CustomElevatedButton(
          text: 'Save',
          ontap: () {
            if (startPicked == null || endPicked == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Please select both start and end dates")),
              );
              return;
            }

            resumeData.addEducation(
              degreeController.text,
              collegeController.text,
              dateFormat.format(startPicked!),
              dateFormat.format(endPicked!),
              descController.text,
            );
            ScaffoldMessenger.of(context).showSnackBar(showSnack());
          },
        ),
      ],
    );
  }
}
