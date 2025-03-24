import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/config/api/export.dart';
import 'package:yuvaprabha/core/global/custom_button.dart';
import 'package:yuvaprabha/core/global/custom_snack.dart';
import 'package:yuvaprabha/core/global/custom_text_field.dart';
import 'package:yuvaprabha/core/provider/resume_data_provider.dart';

class BasicInfoPage extends StatelessWidget {
   BasicInfoPage({super.key});

    final FocusNode aNode = FocusNode();
    final FocusNode bNode = FocusNode();
    final FocusNode cNode = FocusNode();
    final FocusNode dNode = FocusNode();
    final FocusNode eNode = FocusNode();
    final FocusNode fNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final resumeData = Provider.of<ResumeDataProvider>(context);

    TextEditingController nameController;
    TextEditingController titleController;
    TextEditingController emailController;
    TextEditingController phoneController;
    TextEditingController addressController;
    TextEditingController summaryController;

    nameController = TextEditingController(text: resumeData.fullName);
    titleController = TextEditingController(text: resumeData.jobTitle);
    emailController = TextEditingController(text: resumeData.email);
    phoneController = TextEditingController(text: resumeData.phone);
    addressController = TextEditingController(text: resumeData.address);
    summaryController = TextEditingController(text: resumeData.summary);


    return Column(
      children: [
        Text(
          'Basic Information',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        h16,
        CustomTextField(
          hint: 'Full name',
          controller: nameController,
          focusNode: aNode,
          nextFocus: bNode,
        ),
        CustomTextField(
          hint: 'Job Title',
          controller: titleController,
          focusNode: bNode,
          nextFocus: cNode,
        ),
        CustomTextField(
          hint: 'Email',
          controller: emailController,
          type: TextInputType.emailAddress,
          focusNode: cNode,
          nextFocus: dNode,
        ),
        CustomTextField(
          hint: 'Phone',
          controller: phoneController,
          type: TextInputType.visiblePassword,
          focusNode: dNode,
          nextFocus: eNode,
        ),
        CustomTextField(
          hint: 'City, Country',
          controller: addressController,
          type: TextInputType.streetAddress,
          focusNode: eNode,
          nextFocus: fNode,
        ),
        CustomTextField(
          hint: 'Summary',
          controller: summaryController,
          focusNode: fNode,
          isPara: true,
        ),
        h12,
        CustomElevatedButton(
          text: 'Save',
          ontap: () {
            resumeData.updateBasicInfo(
              nameController.text,
              titleController.text,
              emailController.text,
              phoneController.text,
              addressController.text,
            );
            ScaffoldMessenger.of(context).showSnackBar(showSnack());
          },
        )
      ],
    );
  }
}
