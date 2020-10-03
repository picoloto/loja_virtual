import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product_manager.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';

class SelectProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Produto'),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (_, manager, __){
          return ListView.builder(
            itemCount: manager.allProducts.length,
            itemBuilder: (_, index){
              final product = manager.allProducts[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                title: Text(product.name),
                leading: SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(product.images.first, fit: BoxFit.cover),
                ),
                onTap: (){
                  navigatorPop(context: context, params: product);
                },
              );
            },
          );
        },
      ),
    );
  }
}
