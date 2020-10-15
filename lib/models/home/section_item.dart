

import 'package:loja_virtual/utils/const/section_item_constants.dart';

class SectionItem {
  dynamic image;
  String product;

  SectionItem({this.image, this.product});

  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map[sectionItemImage] as String;
    product = map[sectionItemProduct] as String;
  }

  SectionItem clone() {
    return SectionItem(
      image: image,
      product: product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      sectionItemImage: image,
      sectionItemProduct: product,
    };
  }
}
