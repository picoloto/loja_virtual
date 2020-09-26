import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/home/section_item.dart';

const modelName = 'name';
const modelType = 'type';
const modelItems = 'items';

class Section extends ChangeNotifier {
  String name;
  String type;
  List<SectionItem> items;

  Section({this.name, this.type, this.items}) {
    items = items ?? [];
  }

  Section.fromDocument(DocumentSnapshot document) {
    name = document.data[modelName] as String;
    type = document.data[modelType] as String;
    items = (document.data[modelItems] as List)
        .map((e) => SectionItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Section clone() {
    return Section(
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

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
