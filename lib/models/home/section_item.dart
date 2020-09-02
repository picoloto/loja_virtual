const modelImage = 'image';
const modelProduct = 'product';

class SectionItem {
  String image;
  String product;

  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map[modelImage] as String;
    product = map[modelProduct] as String;
  }

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }
}
