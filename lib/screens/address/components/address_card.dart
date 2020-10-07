import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/address/components/cep_input_field.dart';

class AddressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ENDEREÇO DE ENTREGA',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            CepInputField()
          ],
        ),
      ),
    );
  }
}
