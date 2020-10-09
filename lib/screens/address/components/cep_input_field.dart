import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/models/cart/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TextFormField(
            controller: cepController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            autocorrect: false,
            validator: (cep) => _validaCep(cep),
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'CEP',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        CustomRaisedButton(
          onPressed: () {
            if(Form.of(context).validate()){
              context.read<CartManager>().getAddress(cepController.text);
            }
          },
          child: const CustomTextFromRaisedButton("Buscar CEP"),
        )
      ],
    );
  }

  String _validaCep(String cep) {
    if (cep.isEmpty) {
      return 'Campo Obrigatório';
    } else if (cep.length != 10) {
      return 'CEP inválido';
    } else {
      return null;
    }
  }
}
