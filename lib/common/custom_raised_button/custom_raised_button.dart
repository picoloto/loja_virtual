import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({this.child, this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        disabledColor: Theme.of(context).primaryColor.withAlpha(176),
        disabledTextColor: Colors.white,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
