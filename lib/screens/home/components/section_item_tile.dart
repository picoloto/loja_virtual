import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home/home_manager.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:loja_virtual/models/home/section_item.dart';
import 'package:loja_virtual/models/product/product_manager.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SectionItemTile extends StatelessWidget {
  const SectionItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return GestureDetector(
      onTap: () => _onTap(context),
      onLongPress: () => _longPress(context, homeManager),
      child: item.image is String
          ? FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.image as String,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      )
          : Image.file(item.image as File),
    );
  }

  void _longPress(BuildContext context, HomeManager homeManager) {
    if(homeManager.editing){
      showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: const Text('Editar Item'),
          actions: [
            FlatButton(
              onPressed: () {
                context.read<Section>().removeItem(item);
                navigatorPop(context: context);
              },
              child: const Text('Excluir'),
            )
          ],
        )
      );
    }
  }

  void _onTap(BuildContext context) {
    if (item.product != null) {
      final product =
      context.read<ProductManager>().findProductById(item.product);
      if (product != null) {
        navigatorPush(context, ProductScreen(product));
      }
    }
  }
}
