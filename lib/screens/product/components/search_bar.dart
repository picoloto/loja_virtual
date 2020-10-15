import 'package:flutter/material.dart';
import 'package:loja_virtual/manager/product_manager.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductManager>(builder: (_, manager, __) {
      return TextFormField(
        cursorColor: Colors.black,
        autofocus: true,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Digite para pesquisar...',
          hintStyle: TextStyle(color: Colors.black),
        ),
        onChanged: (text) {
          manager.search = text;
        },
      );
    });
  }
}
