
import 'package:flutter/material.dart';
import 'package:yuvaprabha/config/extensions/app_extensions.dart';

import '../colors/color_constants.dart';


class CustomRadioTile extends StatelessWidget {
  final VoidCallback? ontap;
  final String? text;
  final int val;
  const CustomRadioTile({super.key, this.text, required this.val, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueGrey.shade100)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text ?? 'data',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Radio<int>(
              fillColor: WidgetStatePropertyAll(primary),
              value: val,
              groupValue: 1,
              onChanged: (value) {},
            )
          ],
        ),
      ),
    ).pOnly(bottom: 16);
  }
}
