import 'package:flutter/material.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/models/endereco/address.dart';
import 'package:loja_virtual/screens/address/components/address_input_field.dart';
import 'package:loja_virtual/screens/address/components/cep_input_field.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<CartManager>(
          builder: (_, manager, __) {
            final address = manager.address ?? Address();
            print(address);

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ENDEREÇO DE ENTREGA',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  CepInputField(address),
                  AddressInputField(address),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
