import 'package:flutter/material.dart';
import 'package:loja_virtual/common/app_primary_color.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/manager/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.buttonText, this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('RESUMO DO PEDIDO',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 12),
            _totalDivide(context, 'Subtotal', 'S', productsPrice),
            _totalDivide(context, 'Entrega', 'S', deliveryPrice),
            _totalDivide(context, 'Total', 'T', totalPrice),
            const SizedBox(height: 12),
            CustomRaisedButton(
              onPressed: onPressed,
              child: CustomTextFromRaisedButton(buttonText),
              loading: false,
            )
          ],
        ),
      ),
    );
  }

  Widget _totalDivide(
      BuildContext context, String text, String type, num price) {
    if (price != null) {
      if (type == 'S') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'R\$ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const Divider()
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Text(
              'R\$ ${price.toStringAsFixed(2)}',
              style: TextStyle(color: appPrimaryColor(context), fontSize: 16),
            ),
          ],
        );
      }
    } else {
      return Container();
    }
  }
}
