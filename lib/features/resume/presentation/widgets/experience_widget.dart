import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/api/export.dart';
import '../../../../core/constants/regex_constants.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_date_picker.dart';
import '../../../../core/global/custom_snack.dart';
import '../../../../core/global/custom_text_field.dart';
import '../../../../core/provider/resume_data_provider.dart';

class ExperiencePage extends StatelessWidget {
  ExperiencePage({super.key});

  final FocusNode aNode = FocusNode();
  final FocusNode bNode = FocusNode();
  final FocusNode cNode = FocusNode();
  final FocusNode dNode = FocusNode();
  dynamic startPicked;
  dynamic endPicked;

  @override
  Widget build(BuildContext context) {
    final resumeData = Provider.of<ResumeDataProvider>(context);
final TextEditingController titleController = TextEditingController(
    text: resumeData.experience.isNotEmpty ? resumeData.experience.first['title'] ?? '' : '');
final TextEditingController companyController = TextEditingController(
    text: resumeData.experience.isNotEmpty ? resumeData.experience.first['company'] ?? '' : '');
final TextEditingController cityController = TextEditingController(
    text: resumeData.experience.isNotEmpty ? resumeData.experience.first['city'] ?? '' : '');
final TextEditingController startController = TextEditingController(
    text: resumeData.experience.isNotEmpty ? resumeData.experience.first['start'] ?? '' : '');
final TextEditingController endController = TextEditingController(
    text: resumeData.experience.isNotEmpty ? resumeData.experience.first['end'] ?? '' : '');
final TextEditingController descController = TextEditingController(
    text: resumeData.experience.isNotEmpty ? resumeData.experience.first['description'] ?? '' : '');

    return Column(
      children: [
        Text(
          'Relevant Experience',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        h16,
        CustomTextField(
          controller: titleController,
          hint: "Job Title",
          focusNode: aNode,
          nextFocus: bNode,
        ),
        CustomTextField(
          controller: companyController,
          hint: "Company Name",
          focusNode: bNode,
          nextFocus: cNode,
        ),
        CustomTextField(
          controller: cityController,
          hint: "City",
          focusNode: cNode,
          nextFocus: dNode,
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
          controller: descController,
          hint: "Description (Optional)",
          focusNode: dNode,
          isPara: true,
        ),
        h12,
        CustomElevatedButton(
          ontap: () {
            if (startPicked == null || endPicked == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Please select both start and end dates")),
              );
              return;
            }

            resumeData.addExperience(
              titleController.text,
              companyController.text,
              cityController.text,
              dateFormat.format(startPicked!),
              dateFormat.format(endPicked!),
              descController.text,
            );
            ScaffoldMessenger.of(context).showSnackBar(showSnack());
          },
          text: "Save",
        ),
      ],
    );
  }
}
