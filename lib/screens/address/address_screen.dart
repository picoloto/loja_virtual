import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/screens/address/components/address_card.dart';
import 'package:loja_virtual/screens/checkout/checkout_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';
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
          Consumer<CartManager>(builder: (_, manager, __) {
            return PriceCard(
              buttonText: 'PAGAMENTO',
              onPressed: manager.isAddressValid
                  ? () => navigatorPush(context, CheckoutScreen())
                  : null,
            );
          }),
        ],
      ),
    );
  }
}
