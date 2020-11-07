import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/models/order/order.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/utils/const/aux_constants.dart';
import 'package:loja_virtual/utils/const/checkout_constants.dart';
import 'package:loja_virtual/utils/const/product_constants.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
      _loading = value;
      notifyListeners();
  }
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

  Future<void> checkout({Function onStockFail, Function onSuccess}) async {
    loading = true;
    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    // TODO PROCESSAR PAGAMENTO

    final orderId = await _getOrderId();
    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();

    await order.save();
    cartManager.clear();
    onSuccess();
    loading = false;
  }

  Future<void> _decrementStock() {
    return firestore.runTransaction((transaction) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for (final item in cartManager.items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == item.productId)) {
          product = productsToUpdate.firstWhere((p) => p.id == item.productId);
        } else {
          final doc = await transaction
              .get(firestore.document('$productCollection/${item.productId}'));
          product = Product.fromDocument(doc);
        }

        item.product = product;

        final version = product.findVersion(item.version);
        if (version.stock - item.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          version.stock -= item.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} produto(s) sem estoque');
      }

      for (final product in productsToUpdate) {
        transaction.update(
            firestore.document('$productCollection/${product.id}'),
            {productVersions: product.versionMapFromList()});
      }
    });
  }
}
