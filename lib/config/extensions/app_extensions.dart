import 'package:flutter/material.dart';

extension SizedBoxExtension on Widget {
  Widget w(double width, {Key? key}) {
    return SizedBox(
      key: key,
      width: width,
      child: this,
    );
  }

  Widget h(double height, {Key? key}) {
    return SizedBox(
      key: key,
      height: height,
      child: this,
    );
  }

  Widget wh(double width, double height, {Key? key}) {
    return SizedBox(
      key: key,
      width: width,
      height: height,
      child: this,
    );
  }

  Widget wFul(BuildContext context, {Key? key}) {
    return SizedBox(
      key: key,
      width: MediaQuery.of(context).size.width,
      child: this,
    );
  }

  Widget hFul(BuildContext context, {Key? key}) {
    return SizedBox(
      key: key,
      height: MediaQuery.of(context).size.height,
      child: this,
    );
  }

  Widget whFul(BuildContext context, {Key? key}) {
    return SizedBox(
      key: key,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: this,
    );
  }

  Widget p(double padding, {Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget pSymmetric(
      {double horizontal = 0.0, double vertical = 0.0, Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget px(double horizontal, {Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: this,
    );
  }

  Widget py(double vertical, {Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: this,
    );
  }

  Widget pOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    Key? key,
  }) {
    return Padding(
      key: key,
      padding:
          EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }
}
