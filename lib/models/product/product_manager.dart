import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;
  List<Product> allProducts = [];
  String _search = '';
  bool _isSearching = false;

  bool get isSearching => _isSearching;
  String get search => _search;

  set isSearching (bool val){
    _isSearching = val;
    notifyListeners();
  }
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where((element) =>
          element.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapshot =
        await firestore.collection('products').getDocuments();
    allProducts =
        snapshot.documents.map((e) => Product.fromDocument(e)).toList();
    notifyListeners();
  }
}
