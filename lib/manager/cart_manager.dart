import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual/manager/user_manager.dart';
import 'package:loja_virtual/models/cart/cart_product.dart';
import 'package:loja_virtual/models/endereco/address.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/user/user.dart';
import 'package:loja_virtual/services/cepaberto_service.dart';
import 'package:loja_virtual/utils/const/aux_constants.dart';

class CartManager extends ChangeNotifier {
  User user;
  List<CartProduct> items = [];
  num productsPrice = 0.0;
  num deliveryPrice;
  Address address;
  bool _loading = false;
  final Firestore firestore = Firestore.instance;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  bool get isAddressValid => address != null && deliveryPrice != null;

  bool get loading => _loading;

  bool get isCartValid {
    for (final item in items) {
      if (!item.hasStock) {
        return false;
      }
    }
    return true;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateUser(UserManager userManager) {
    user = userManager.user;
    productsPrice = 0;
    items.clear();
    removeAddress();

    if (user != null) {
      _loadCartItems();
      _loadingUserAddress();
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

  Future<void> getAddress(String cep) async {
    loading = true;

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
      }
      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('Cep inválido');
    }
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;

    if (await calculateDelivery(address.lat, address.long)) {
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega =(');
    }
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.document(auxDelivery).get();
    final deliveryLat = doc.data[auxDeliveryLat] as double;
    final deliveryLong = doc.data[auxDeliveryLong] as double;
    final deliveryMaxkm = doc.data[auxDeliveryMaxkm] as num;
    final deliveryBase = doc.data[auxDeliveryBase] as num;
    final deliveryPricekm = doc.data[auxDeliveryPricekm] as num;

    double distance = distanceBetween(deliveryLat, deliveryLong, lat, long);
    distance /= 1000;

    debugPrint('distance $distance');

    if (distance > deliveryMaxkm) {
      debugPrint('distance > deliveryMaxkm');
      return false;
    }

    deliveryPrice = deliveryBase + distance * deliveryPricekm;
    return true;
  }

  Future<void> _loadingUserAddress() async {
    if (user.address != null &&
        await calculateDelivery(user.address.lat, user.address.long)) {
      address = user.address;
      notifyListeners();
    }
  }
}
