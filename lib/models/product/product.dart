import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product_version.dart';

const modelName = 'name';
const modelDescription = 'description';
const modelImages = 'images';
const modelVersions = 'versions';

class Product extends ChangeNotifier {
  String id;
  String name;
  String description;
  List<String> images;
  List<ProductVersion> versions;
  ProductVersion _selectedVersion;

  Product({this.id, this.name, this.description, this.images, this.versions}) {
    images = images ?? [];
    versions = versions ?? [];
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document[modelName] as String;
    description = document[modelDescription] as String;
    images = List<String>.from(document.data[modelImages] as List<dynamic>);
    versions = (document.data[modelVersions] as List<dynamic> ?? [])
        .map((e) => ProductVersion.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  ProductVersion get selectedVersion => _selectedVersion;

  bool get hasStock => totalStock > 0;

  int get totalStock {
    int stock = 0;
    for (final version in versions) {
      stock += version.stock;
    }
    return stock;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final version in versions) {
      if (version.price < lowest && version.hasStock) {
        lowest = version.price;
      }
    }
    return lowest;
  }

  set selectedVersion(ProductVersion val) {
    _selectedVersion = val;
    notifyListeners();
  }

  ProductVersion findVersion(String name) {
    try {
      return versions.firstWhere((e) => e.name == name);
    } catch (e) {
      return null;
    }
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      versions: versions.map((e) => e.clone()).toList(),
    );
  }
}
