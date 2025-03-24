import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/core/global/custom_button.dart';
import 'package:yuvaprabha/core/global/custom_snack.dart';
import 'package:yuvaprabha/core/provider/resume_data_provider.dart';

import '../../../../config/api/export.dart';
import '../../../../core/constants/regex_constants.dart';
import '../../../../core/global/custom_date_picker.dart';
import '../../../../core/global/custom_text_field.dart';

class PersonalDetailsPage extends StatelessWidget {
  PersonalDetailsPage({super.key});


  final FocusNode aNode = FocusNode();
  final FocusNode bNode = FocusNode();
  final FocusNode cNode = FocusNode();
  final FocusNode dNode = FocusNode();
  final FocusNode eNode = FocusNode();
  final FocusNode fNode = FocusNode();

  dynamic dobPicked;
  @override
  Widget build(BuildContext context) {
    final resumeData = Provider.of<ResumeDataProvider>(context);

  TextEditingController dobController = TextEditingController(text: resumeData.dob);
  TextEditingController nationalityController = TextEditingController(text: resumeData.nationality);
  TextEditingController linkedInController = TextEditingController(text: resumeData.linkedIn);
  TextEditingController githubController = TextEditingController(text: resumeData.github);
  TextEditingController dribbbleController = TextEditingController(text: resumeData.dribbble);
  TextEditingController behanceController = TextEditingController(text: resumeData.behance);
  TextEditingController otherController = TextEditingController(text: resumeData.other);
    return Column(
      children: [
        Text(
          'Personal Details',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        h16,
        Row(children: [
          Expanded(
            child: CustomDatePicker(
              ontap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  dobPicked = picked;
                  dobController.text = dateFormat.format(picked);
                }
              },
              text: 'Date of Birth',
              date: dobController.text.isEmpty ? null : dobController.text,
            ),
          ),
        ]),
        CustomTextField(
          hint: 'Nationality',
          controller: nationalityController,
          focusNode: aNode,
          nextFocus: bNode,
        ),
        CustomTextField(
          hint: 'LinkedIn',
          controller: linkedInController,
          focusNode: bNode,
          nextFocus: cNode,
        ),
        CustomTextField(
          hint: 'GitHub',
          controller: githubController,
          focusNode: cNode,
        ),
        // CustomTextField(hint: 'Dribbble', controller: dribbbleController,focusNode: aNode,nextFocus: bNode,),
        // CustomTextField(hint: 'Behance', controller: behanceController,focusNode: aNode,nextFocus: bNode,),
        // CustomTextField(hint: 'Other', controller: otherController,focusNode: aNode,nextFocus: bNode,),
        h12,

        CustomElevatedButton(
          ontap: () {
            if (dobPicked == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please select dob")),
              );
              return;
            }

            resumeData.updatePersonalDetails(
              dateFormat.format(dobPicked!),
              nationalityController.text,
              linkedInController.text,
              githubController.text,
              dribbbleController.text,
              behanceController.text,
              otherController.text,
            );
            ScaffoldMessenger.of(context).showSnackBar(showSnack());
          },
          text: 'Save',
        ),
      ],
    );
  }
}
