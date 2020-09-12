import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: InkWell(
        onTap: () => navigatorPush(context, ProductScreen(product)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(product.images.first, fit: BoxFit.cover),
              ),
              Expanded(
                child: ListTile(
                  title: Text(product.name),
                  subtitle: const Text('A partir de'),
                  trailing: Text('R\$ ${product.basePrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
