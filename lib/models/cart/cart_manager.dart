import 'package:loja_virtual/models/cart/cart_product.dart';
import 'package:loja_virtual/models/product/product.dart';

class CartManager {

  List<CartProduct> items = [];

  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }

}