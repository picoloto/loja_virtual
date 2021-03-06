import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/utils/const/product_constants.dart';

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

  set isSearching(bool val) {
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
        await firestore.collection(productCollection).getDocuments();
    allProducts =
        snapshot.documents.map((e) => Product.fromDocument(e)).toList();
    notifyListeners();
  }

  Product findProductById(String product) {
    try {
      return allProducts.firstWhere((e) => e.id == product);
    } catch (e) {
      return null;
    }
  }

  void update(Product product) {
    allProducts.removeWhere((element) => element.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }
}
