import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';

class InfoLoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 100,
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Faça login para acessar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomRaisedButton(
                onPressed: () => navigatorPush(context, LoginScreen()),
                loading: false,
                child: const CustomTextFromRaisedButton('LOGIN'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
