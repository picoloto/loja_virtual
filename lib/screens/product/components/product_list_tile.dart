import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(product.images.first),
            ),
            Expanded(
              child: ListTile(
                title: Text(product.name),
                subtitle: const Text('A partir de'),
                trailing: Text('R\$ 19.99',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
