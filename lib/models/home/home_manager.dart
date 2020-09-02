import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/home/section.dart';

class HomeManager extends ChangeNotifier{
  final Firestore firestore = Firestore.instance;
  List<Section> sections = [];

  HomeManager() {
    _loadSections();
  }

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((event) {
      sections = [];
      for (final DocumentSnapshot document in event.documents) {
        sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }
}
