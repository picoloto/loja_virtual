import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product_version.dart';
import 'package:loja_virtual/utils/const/product_constants.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  String id;
  String name;
  String description;
  List<String> images;
  List<ProductVersion> versions;
  ProductVersion _selectedVersion;
  List<dynamic> newImages;
  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool _loading = false;

  Product({this.id, this.name, this.description, this.images, this.versions}) {
    images = images ?? [];
    versions = versions ?? [];
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document[productName] as String;
    description = document[productDescription] as String;
    images = List<String>.from(document.data[productImages] as List<dynamic>);
    versions = (document.data[productVersions] as List<dynamic> ?? [])
        .map((e) => ProductVersion.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ProductVersion get selectedVersion => _selectedVersion;

  DocumentReference get firestoreRef =>
      firestore.document('$productCollection/$id');

  StorageReference get storageRef =>
      storage.ref().child(productCollection).child(id);

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

  Future<void> save() async {
    loading = true;
    if (id == null) {
      await firestore
          .collection(productCollection)
          .add(productFromMap())
          .then((doc) => id = doc.documentID);
    } else {
      await firestoreRef.updateData(productFromMap());
    }

    await _trataImagens();
    loading = false;
  }

  Future<void> _trataImagens() async {
    final List<String> updateImages = [];
    await _trataImagensAtualizadas(updateImages);
    await _removeImagensNaoUtilizadas(updateImages);
    await firestoreRef.updateData({productImages: updateImages});
    images = updateImages;
  }

  Future<void> _trataImagensAtualizadas(List<String> updateImages) async {
    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }
  }

  Future<void> _removeImagensNaoUtilizadas(List<String> updateImages) async {
    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) {
          debugPrint('falha ao deletar $image');
        }
      }
    }
  }

  Map<String, dynamic> productFromMap() {
    return {
      productName: name,
      productDescription: description,
      productVersions: versionMapFromList(),
    };
  }

  List<Map<String, dynamic>> versionMapFromList() {
    return versions.map((e) => e.toMap()).toList();
  }
}
