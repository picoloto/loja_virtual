import 'package:flutter/material.dart';

class CustomTextFromRaisedButton extends StatelessWidget {
  const CustomTextFromRaisedButton(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18),
    );
  }
}
