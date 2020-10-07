import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextFormField(
            // controller: emailController,
            // enabled: !userManager.loading,
            keyboardType: TextInputType.number,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            autocorrect: false,
            // validator: (email) => _validaEmail(email),
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'CEP',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        CustomRaisedButton(
          onPressed: () {},
          child: const CustomTextFromRaisedButton("Buscar CEP"),
        )
      ],
    );
  }
}
