import 'package:flutter/material.dart';
import 'package:loja_virtual/common/app_primary_color.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({this.child, this.onPressed, this.loading});

  final Widget child;
  final VoidCallback onPressed;
  final bool loading;

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
        onPressed: !loading ? onPressed : null,
        child: !loading
            ? child
            : const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
