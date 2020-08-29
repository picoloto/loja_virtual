import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/product/product_version.dart';

const modelPid = 'pid';
const modelQuantity = 'quantity';
const modelVersion = 'version';

class CartProduct extends ChangeNotifier {
  String id;
  String productId;
  int quantity;
  String version;
  Product product;
  final Firestore firestore = Firestore.instance;

  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    version = product.selectedVersion.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data[modelPid] as String;
    quantity = document.data[modelQuantity] as int;
    version = document.data[modelVersion] as String;

    firestore
        .document('products/$productId')
        .get()
        .then((value) => product = Product.fromDocument(value));
  }

  ProductVersion get productVersion {
    if (product == null) return null;
    return product.findVersion(version);
  }

  num get unitPrice {
    if (product == null) return 0;
    return productVersion?.price ?? 0;
  }

  Map<String, dynamic> toCartItemMap() {
    final Map<String, dynamic> map = {
      modelPid: productId,
      modelQuantity: quantity,
      modelVersion: version,
    };
    return map;
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedVersion.name == version;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final version = productVersion;
    if (version == null) {
      return false;
    }
    return version.stock >= quantity;
  }

  num get totalPrice => unitPrice * quantity;
}
