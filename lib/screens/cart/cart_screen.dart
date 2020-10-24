import 'package:flutter/material.dart';
import 'package:loja_virtual/common/empty_indicator.dart';
import 'package:loja_virtual/common/info_login_card.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
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
          if(manager.user == null){
            return InfoLoginCard();
          }

          if(manager.items.isEmpty){
            return const EmptyIndicator(
              iconData: Icons.remove_shopping_cart,
              title: 'Nenhum produto no carrinho!',
            );
          }
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
