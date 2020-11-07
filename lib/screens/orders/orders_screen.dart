import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/empty_indicator.dart';
import 'package:loja_virtual/common/info_login_card.dart';
import 'package:loja_virtual/manager/orders_manager.dart';
import 'package:loja_virtual/screens/orders/components/order_tile.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, manager, __) {
          if (manager.user == null) {
            return InfoLoginCard();
          }

          if (manager.orders.isEmpty) {
            return const EmptyIndicator(
              iconData: Icons.border_clear,
              title: 'Nenhum pedido encontrado!',
            );
          }

          return ListView.builder(
            itemCount: manager.orders.length,
            itemBuilder: (___, index){
              return OrderTile(
                  manager.orders.reversed.toList()[index]
              );
            },
          );
        },
      ),
    );
  }
}
