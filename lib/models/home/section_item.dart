const modelImage = 'image';
const modelProduct = 'product';

class SectionItem {
  String image;
  String product;

  SectionItem({this.image, this.product});

  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map[modelImage] as String;
    product = map[modelProduct] as String;
  }

  SectionItem clone() {
    return SectionItem(
      image: image,
      product: product,
    );
  }

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }
}
