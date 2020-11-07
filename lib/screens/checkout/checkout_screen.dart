import 'package:flutter/material.dart';
import 'package:loja_virtual/common/loading_from_card.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/manager/checkout_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, manager, __) {
            return _listAndLoading(manager, context);
          },
        ),
      ),
    );
  }

  Widget _listAndLoading(CheckoutManager manager, BuildContext context) {
    if (!manager.loading) {
      return ListView(
        children: [
          PriceCard(
            buttonText: 'FINALIZAR PEDIDO',
            onPressed: () {
              manager.checkout(
                onStockFail: (e) {
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('$e'),
                    backgroundColor: Colors.red[700],
                  ));
                },
                onSuccess: () {
                  // TODO CORRIGIR AQUI PQ NÃO ESTA VOLTANDO CORRETAMENTE
                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    debugPrint(route.toString());
                    return count++ == 3;
                  });
                },
              );
            },
          )
        ],
      );
    } else {
      return LoadingFromCard();
    }
  }
}
