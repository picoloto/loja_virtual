import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/manager/product_manager.dart';
import 'package:loja_virtual/manager/user_manager.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/product/components/product_list_tile.dart';
import 'package:loja_virtual/screens/product/edit_product_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';

import 'components/search_bar.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      floatingActionButton: Consumer<UserManager>(
          builder: (_, manager, __) =>
              _floatActionButtonAddProduct(context, manager.adminEnabled)),
      appBar: AppBar(
        title: Consumer<ProductManager>(builder: (_, manager, __) {
          return manager.isSearching ? SearchBar() : const Text('Produtos');
        }),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(
              builder: (_, manager, __) => _searchManager(manager)),
          IconButton(
            onPressed: () => navigatorPush(context, CartScreen()),
            icon: const Icon(Icons.shopping_cart),
          ),
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

  Widget _floatActionButtonAddProduct(BuildContext context, bool isAdmin) {
    return isAdmin
        ? FloatingActionButton(
            onPressed: () =>
                navigatorPush(context, EditProductScreen(Product())),
            child: const Icon(Icons.add),
          )
        : Container();
  }

  Widget _searchManager(ProductManager manager) {
    return !manager.isSearching
        ? IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => manager.isSearching = true,
          )
        : IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              manager.isSearching = false;
              manager.search = '';
            },
          );
  }
}
