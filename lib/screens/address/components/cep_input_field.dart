import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/common/app_primary_color.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/models/endereco/address.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  final Address address;
  final TextEditingController cepController = TextEditingController();

  CepInputField(this.address);

  @override
  Widget build(BuildContext context) {
    if (address.zipCode == null) {
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
              if (Form.of(context).validate()) {
                context.read<CartManager>().getAddress(cepController.text);
              }
            },
            child: const CustomTextFromRaisedButton("Buscar CEP"),
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CEP: ${address.zipCode}',
                style: TextStyle(
                    color: appPrimaryColor(context), fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            CustomIconButton(
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
              color: appPrimaryColor(context),
              iconData: Icons.edit,
              size: 20,
            )
          ],
        ),
      );
    }
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
