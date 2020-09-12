import 'package:flutter/material.dart';

class CustomLoaderRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        disabledColor: Theme.of(context).primaryColor.withAlpha(176),
        disabledTextColor: Colors.white,
        onPressed: null,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }
}
