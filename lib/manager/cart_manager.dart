import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/manager/user_manager.dart';
import 'package:loja_virtual/models/cart/cart_product.dart';
import 'package:loja_virtual/models/endereco/address.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/user/user.dart';
import 'package:loja_virtual/services/cepaberto_service.dart';

class CartManager extends ChangeNotifier {
  User user;
  List<CartProduct> items = [];
  num productsPrice = 0.0;
  Address address;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  void addToCart(Product product) {
    try {
      final productStackable = items.firstWhere((e) => e.stackable(product));
      productStackable.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap()).then((value) {
        cartProduct.id = value.documentID;
        _onItemUpdated();
      });
    }
    notifyListeners();
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot snapshot = await user.cartReference.getDocuments();
    items = snapshot.documents
        .map((e) => CartProduct.fromDocument(e)..addListener(_onItemUpdated))
        .toList();
  }

  void _onItemUpdated() {
    productsPrice = 0;
    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      if (item.quantity == 0) {
        removeFromCart(item);
        i--;
        continue;
      }

      productsPrice += item.totalPrice;
      _updateCartProduct(item);
    }

    notifyListeners();
  }

  void _updateCartProduct(CartProduct item) {
    user.cartReference.document(item.id).updateData(item.toCartItemMap());
  }

  void removeFromCart(CartProduct item) {
    items.removeWhere((e) => e.id == item.id);
    user.cartReference.document(item.id).delete();
    item.removeListener(_onItemUpdated);
    notifyListeners();
  }

  bool get isCartValid {
    for (final item in items) {
      if (!item.hasStock) {
        return false;
      }
    }
    return true;
  }

  Future<void> getAddress(String cep) async {
    final cepAbertoService = CepAbertoService();

    try {
      final cepabertoEndereco = await cepAbertoService.getAddressFromCep(cep);
      if (cepabertoEndereco != null) {
        address = Address(
            street: cepabertoEndereco.logradouro,
            district: cepabertoEndereco.bairro,
            zipCode: cepabertoEndereco.cep,
            city: cepabertoEndereco.cidade.nome,
            state: cepabertoEndereco.estado.sigla,
            lat: cepabertoEndereco.latitude,
            long: cepabertoEndereco.longitude);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeAddress() {
    address = null;
    notifyListeners();
  }
}
