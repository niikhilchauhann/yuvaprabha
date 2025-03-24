import 'package:flutter/material.dart';
import 'package:yuvaprabha/config/api/export.dart';

SnackBar showSnack({String? content}) {
  return SnackBar(
    content: Text(
      content ?? 'Changes saved! Go to next step',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: primary,
  );
}
