import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/home/section.dart';

class HomeManager {
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
    });
  }
}
