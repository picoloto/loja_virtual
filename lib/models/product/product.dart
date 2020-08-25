import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product_version.dart';

class Product extends ChangeNotifier{
  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    versions = (document.data['versions'] as List<dynamic> ?? [])
        .map((e) => ProductVersion.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  String id;
  String name;
  String description;
  List<String> images;
  List<ProductVersion> versions;

  ProductVersion _selectedVersion;
  ProductVersion get selectedVersion => _selectedVersion;
  set selectedVersion(ProductVersion val){
    _selectedVersion = val;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for(final version in versions){
      stock += version.stock;
    }
    return stock;
  }
  bool get hasStock => totalStock > 0;
}
