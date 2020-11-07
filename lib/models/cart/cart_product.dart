import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/product/product_version.dart';
import 'package:loja_virtual/utils/const/cart_product_constants.dart';

class CartProduct extends ChangeNotifier {
  String id;
  String productId;
  int quantity;
  String version;
  Product _product;
  num fixedPrice;
  final Firestore firestore = Firestore.instance;

  Product get product => _product;

  set product(Product value) {
    _product = value;
    notifyListeners();
  }

  CartProduct.fromProduct(this._product) {
    productId = product.id;
    quantity = 1;
    version = product.selectedVersion.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data[cartProductPid] as String;
    quantity = document.data[cartProductQuantity] as int;
    version = document.data[cartProductVersion] as String;

    firestore.document('products/$productId').get().then((value) {
      product = Product.fromDocument(value);
    });
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
      cartProductPid: productId,
      cartProductQuantity: quantity,
      cartProductVersion: version,
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

  Map<String, dynamic> toOrderItemMap() {
    return {
      cartProductPid: productId,
      cartProductQuantity: quantity,
      cartProductVersion: version,
      cartProductFixedPrice: fixedPrice ?? unitPrice,
    };
  }
}
