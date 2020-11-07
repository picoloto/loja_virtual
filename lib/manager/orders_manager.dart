import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order/order.dart';
import 'package:loja_virtual/models/user/user.dart';
import 'package:loja_virtual/utils/const/oder.constants.dart';

class OrdersManager extends ChangeNotifier {
  User user;
  List<Order> orders = [];
  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateUser(User user) {
    this.user = user;
    orders.clear();
    _subscription?.cancel();

    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore
        .collection(ordersCollection)
        .where(orderUser, isEqualTo: user.id)
        .snapshots()
        .listen((event) {
      orders.clear();
      for (final doc in event.documents) {
        orders.add(Order.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
