import 'package:flutter/material.dart';
import 'package:loja_virtual/common/app_primary_color.dart';

class CustomLoaderRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: appPrimaryColor(context),
        textColor: Colors.white,
        disabledColor: appPrimaryColor(context).withAlpha(176),
        disabledTextColor: Colors.white,
        onPressed: null,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }
}
