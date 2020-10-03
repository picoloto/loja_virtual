import 'package:flutter/material.dart';

class CustomErrorText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Alignment alignment;

  const CustomErrorText({this.text, this.fontSize, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(color: Colors.red, fontSize: fontSize),
      ),
    );
  }
}
