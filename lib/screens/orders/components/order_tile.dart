import 'package:flutter/material.dart';
import 'package:loja_virtual/common/app_primary_color.dart';
import 'package:loja_virtual/models/order/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: appPrimaryColor(context),
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Text(
              'Entregue',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: appPrimaryColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
