import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart/cart_manager.dart';
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
          return Column(
            children: manager.items.map((e) => CartTile(e)).toList(),
          );
        },
      ),
    );
  }
}
