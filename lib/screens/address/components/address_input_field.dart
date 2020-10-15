import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/common/custom_field_decoration.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/models/endereco/address.dart';
import 'package:loja_virtual/utils/validators.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    if(address.zipCode != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: address.street,
              enabled: false,
              validator: emptyField,
              onSaved: (street) => address.street = street,
              decoration: CustomFieldInputDecoration(label: 'Rua/Avenida'),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                    child: TextFormField(
                      initialValue: address.number,
                      validator: emptyField,
                      onSaved: (number) => address.number = number,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: CustomFieldInputDecoration(label: 'Número'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      initialValue: address.complement,
                      onSaved: (complement) => address.complement = complement,
                      decoration: CustomFieldInputDecoration(
                          label: 'Complemento(opcional)'),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: address.district,
              enabled: false,
              validator: emptyField,
              onSaved: (district) => address.district = district,
              decoration: CustomFieldInputDecoration(label: 'Bairro'),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                    child: TextFormField(
                      initialValue: address.city,
                      enabled: false,
                      validator: emptyField,
                      onSaved: (city) => address.city = city,
                      decoration: CustomFieldInputDecoration(label: 'Cidade'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      initialValue: address.state,
                      enabled: false,
                      validator: (state) =>
                          emptyFieldAndBoolCondition(state, state.length != 2),
                      onSaved: (state) => address.state = state,
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 2,
                      decoration: CustomFieldInputDecoration(label: 'UF'),
                    ),
                  ),
                )
              ],
            ),
            CustomRaisedButton(
              onPressed: () {},
              child: const CustomTextFromRaisedButton("Calcular Frete"),
            )
          ],
        ),
      );
    }else{
      return Container();
    }
  }
}
