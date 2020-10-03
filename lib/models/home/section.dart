import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/home/section_constants.dart';
import 'package:loja_virtual/models/home/section_item.dart';
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier {
  String id;
  String name;
  String type;
  List<SectionItem> items;
  List<SectionItem> originalItems;
  String _error;
  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  String get error => _error;

  DocumentReference get firestoreRef =>
      firestore.document('$sectionCollection/$id');

  StorageReference get storageRef =>
      storage.ref().child("$sectionCollection/$id");

  Section({this.id, this.name, this.type, this.items}) {
    items = items ?? [];
    originalItems = List.from(items);
  }

  set error(String value) {
    _error = value;
    notifyListeners();
  }

  Section.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data[sectionName] as String;
    type = document.data[sectionType] as String;
    items = (document.data[sectionItems] as List)
        .map((e) => SectionItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Section clone() {
    return Section(
      id: id,
      name: name,
      type: type,
      items: items.map((e) => e.clone()).toList(),
    );
  }

  void addItem(SectionItem sectionItem) {
    items.add(sectionItem);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }

  bool valid() {
    if (name == null || name.isEmpty) {
      error = 'Titulo inválido';
    } else if (items.isEmpty) {
      error = 'Insira ao menos uma imagem';
    } else {
      error = null;
    }

    return error == null;
  }

  Future<void> save(int pos) async {
    if (id == null) {
      await firestore
          .collection(sectionCollection)
          .add(sectionFromMap(pos))
          .then((doc) => id = doc.documentID);
    } else {
      await firestoreRef.updateData(sectionFromMap(pos));
    }

    await _trataImagens();
  }

  Map<String, dynamic> sectionFromMap(int pos) {
    return {sectionName: name, sectionType: type, sectionPos: pos};
  }

  Map<String, dynamic> itemsFromMap() {
    return {
      sectionItems: items.map((e) => e.toMap()).toList(),
    };
  }

  Future<void> _trataImagens() async {
    await _trataImagensAtualizadas();
    await _removeImagensNaoUtilizadas();
    await firestoreRef.updateData(itemsFromMap());
  }

  Future<void> _trataImagensAtualizadas() async {
    for (final item in items) {
      if (item.image is File) {
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(item.image as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        item.image = url;
      }
    }
  }

  Future<void> _removeImagensNaoUtilizadas() async {
    for (final original in originalItems) {
      if (!items.contains(original)) {
        try {
          final ref =
              await storage.getReferenceFromUrl(original.image as String);
          await ref.delete();
        } catch (e) {
          debugPrint('falha ao deletar $original');
        }
      }
    }
  }

  Future<void> delete() async {
    await firestoreRef.delete();
    for (final item in items) {
      try {
        final ref = await storage.getReferenceFromUrl(item.image as String);
        await ref.delete();
      } catch (e) {
        debugPrint('falha ao deletar $item');
      }
    }
  }
}
