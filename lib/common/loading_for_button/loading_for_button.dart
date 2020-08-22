import 'package:flutter/material.dart';

class LoadingForButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.white),
    );
  }
}
