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

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.documentID;
    price = doc.data[orderPrice] as num;
    userId = doc.data[orderUser] as String;
    address = Address.fromMap(doc.data[orderAddress] as Map<String, dynamic>);
    date = doc.data[orderDate] as Timestamp;
    items = (doc.data[orderItems] as List<dynamic>)
        .map((e) => CartProduct.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  String get formattedId => '#${orderId.padLeft(6, '0')}';

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

  @override
  String toString() {
    return 'Order{orderId: $orderId, userId: $userId, price: $price, items: $items, address: $address, date: $date}\n';
  }
}
