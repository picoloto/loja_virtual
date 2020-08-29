import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/cart/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product.images.first, fit: BoxFit.cover),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(cartProduct.product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('Versão: ${cartProduct.version}'),
                      const SizedBox(height: 6),
                      Consumer<CartProduct>(
                        builder: (_, cartProduct, __) {
                          return _buscaTextValor(context, cartProduct);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(builder: (_, cartProduct, __) {
                return Column(
                  children: [
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Theme.of(context).primaryColor,
                      onTap: cartProduct.increment,
                    ),
                    Text('${cartProduct.quantity}',
                        style: const TextStyle(fontSize: 20)),
                    CustomIconButton(
                      iconData: cartProduct.quantity > 1
                          ? Icons.remove
                          : Icons.delete,
                      color: cartProduct.quantity > 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey[600],
                      onTap: cartProduct.decrement,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buscaTextValor(BuildContext context, CartProduct cartProduct) {
    if (cartProduct.hasStock) {
      return Text('R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor));
    } else {
      return Text('Sem estoque suficiente',
          style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600]));
    }
  }
}
