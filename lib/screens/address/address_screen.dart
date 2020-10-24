import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/screens/address/components/address_card.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard(),
          Consumer<CartManager>(
            builder: (_, manager, __){
              return PriceCard(
                buttonText: 'Continuar para o Pagamento',
                onPressed: manager.isAddressValid ? (){} : null,
              );
            }
          ),
        ],
      ),
    );
  }
}
