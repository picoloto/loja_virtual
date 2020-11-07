import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:loja_virtual/models/cart/cart_product.dart';
import 'package:loja_virtual/models/endereco/address.dart';
import 'package:loja_virtual/utils/const/oder.constants.dart';

class Order {
  String orderId;
  String userId;
  num price;
  List<CartProduct> items;
  Address address;
  Timestamp date;
  final Firestore firestore = Firestore.instance;

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
  }

  Future<void> save() async {
    firestore.collection(ordersCollection).document(orderId).setData(_toMap());
  }

  Map<String, dynamic> _toMap() {
    return {
      orderItems: items.map((e) => e.toOrderItemMap()).toList(),
      orderPrice: price,
      orderUser: userId,
      orderAddress: address.toMap(),
    };
  }
}
