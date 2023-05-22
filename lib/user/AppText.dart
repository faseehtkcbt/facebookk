import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String? text;
  Color? txtColor;

  double? textSize;

  FontWeight? fw;

  AppText(
      {Key? key,
      required this.text,
      this.textSize,
      this.txtColor = Colors.black,
      this.fw})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: txtColor, fontSize: textSize, fontWeight: fw),
    );
  }
}
