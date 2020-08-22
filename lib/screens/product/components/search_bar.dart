import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product_manager.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductManager>(builder: (_, manager, __) {
      return TextFormField(
        cursorColor: Colors.white,
        autofocus: true,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Digite para pesquisar...',
          hintStyle: TextStyle(color: Colors.white),
        ),
        onChanged: (text) {
          manager.search = text;
        },
      );
    });
  }
}
