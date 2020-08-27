import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart/cart_product.dart';

class CartTile extends StatelessWidget {

  const CartTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product.images.first),
            ),
            Expanded(
              child: ListTile(
                title: Text(cartProduct.product.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Versão: ${cartProduct.version}'),
                    Text('R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme
                                .of(context)
                                .primaryColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
