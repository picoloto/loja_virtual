import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product/product_manager.dart';
import 'package:loja_virtual/screens/product/components/product_list_tile.dart';
import 'package:provider/provider.dart';

import 'components/search_bar.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(builder: (_, manager, __) {
          return manager.isSearching ? SearchBar() : const Text('Produtos');
        }),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(builder: (_, manager, __) {
            return !manager.isSearching
                ? _searchIcon(manager)
                : _closeSearchIcon(manager);
          })
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, manager, __) {
        final filteredProducts = manager.filteredProducts;
        return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(filteredProducts[index]);
            });
      }),
    );
  }

  Widget _searchIcon(ProductManager manager) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => manager.isSearching = true,
    );
  }

  Widget _closeSearchIcon(ProductManager manager) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () async {
        manager.isSearching = false;
        manager.search = '';
      },
    );
  }
}
