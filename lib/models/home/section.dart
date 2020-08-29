import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/home/section_item.dart';

const modelName = 'name';
const modelType = 'type';
const modelItems = 'items';

class Section {
  String name;
  String type;
  List<SectionItem> items;

  Section.fromDocument(DocumentSnapshot document) {
    name = document.data[modelName] as String;
    type = document.data[modelType] as String;
    items = (document.data[modelItems] as List)
        .map((e) => SectionItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
