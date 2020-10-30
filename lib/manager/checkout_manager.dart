import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/utils/const/aux_constants.dart';
import 'package:loja_virtual/utils/const/checkout_constants.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  final Firestore firestore = Firestore.instance;

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
    debugPrint('${cartManager.productsPrice}');
  }

  Future<int> _getOrderId() async {
    final ref = firestore.document(auxOrderCounter);

    try {
      final result = await firestore.runTransaction((t) async {
        final doc = await t.get(ref);
        final orderId = doc.data[auxOrderCounterCurrent] as int;
        await t.update(ref, {auxOrderCounterCurrent: orderId + 1});
        return {checkoutOrderId: orderId};
      });

      return result[checkoutOrderId] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  void checkout() {
    _decrementStock();

    _getOrderId().then((value) => print(value));
  }

  void _decrementStock() {
    // 1. Ler todos os estoques
    // 2. Decremento localmente os estoques
    // 3. Salvar estoques no firebase

    // CART ITEMS
    // Wow  5xd 2xb   5   deluxe
    // wow  5xd 2xb   2   basic
    // lol  1s        1   standart

    // NÃO TENHO ESTOQUE

    // TENHO ESTOQUE
    // PRODUCTS TO UPDATE
    // Wow  5xd 2xb   5   deluxe
    // lol  1s        1   standart

    // DECREMENTAR
    // Wow  0xd 0xb
    // lol  0s

    // ESCREVER NO FIREBASE
  }
}
