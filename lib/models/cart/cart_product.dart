import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/product/product_version.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    version = product.selectedVersion.name;
  }

  String productId;
  int quantity;
  String version;

  Product product;

  ProductVersion get productVersion {
    if (product == null) return null;
    return product.findVersion(version);
  }

  num get unitPrice{
    if (product == null) return 0;
    return productVersion?.price ?? 0;
  }
}
