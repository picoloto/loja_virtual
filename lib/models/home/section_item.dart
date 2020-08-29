const modelImage = 'image';

class SectionItem {
  String image;

  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map[modelImage] as String;
  }

  @override
  String toString() {
    return 'SectionItem{image: $image}';
  }
}
