import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:loja_virtual/models/home/section_constants.dart';

class HomeManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;
  List<Section> _sections = [];
  List<Section> _editingSections = [];
  bool editing = false;
  bool loading = false;

  HomeManager() {
    _loadSections();
  }

  Future<void> _loadSections() async {
    firestore.collection('home').orderBy(sectionPos).snapshots().listen((event) {
      _sections = [];
      for (final DocumentSnapshot document in event.documents) {
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  List<Section> get sections {
    return editing ? _editingSections : _sections;
  }

  void enterEditing() {
    editing = true;
    _editingSections = _sections.map((e) => e.clone()).toList();
    notifyListeners();
  }

  Future<void> saveEditing() async {
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) valid = false;
    }

    if (!valid) {
      notifyListeners();
      return;
    }

    loading = true;
    notifyListeners();

    int pos = 0;
    for(final section in _editingSections){
      await section.save(pos);
      pos++;
    }

    for(final section in List.from(_sections)){
      if(!_editingSections.any((element) => element.id == section.id)){
        await section.delete();
      }
    }

    loading = false;
    editing = false;
    notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }
}
