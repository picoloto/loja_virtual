import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/models/cart/cart_manager.dart';
import 'package:loja_virtual/screens/address/address_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, manager, __) {
          return ListView(
            children: [
              Column(
                children: manager.items.map((e) => CartTile(e)).toList(),
              ),
              PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: !manager.isCartValid
                    ? null
                    : () => navigatorPush(context, AddressScreen()),
              ),
            ],
          );
        },
      ),
    );
  }
}
