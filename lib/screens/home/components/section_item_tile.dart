import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loja_virtual/manager/home_manager.dart';
import 'package:loja_virtual/manager/product_manager.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:loja_virtual/models/home/section_item.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:loja_virtual/screens/product/select_product_screen.dart';
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
    final product =
        context.read<ProductManager>().findProductById(item.product);
    if (homeManager.editing) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Editar Item'),
                content: product != null
                    ? ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(product.name),
                        leading: Image.network(product.images.first),
                      )
                    : null,
                actions: [
                  FlatButton(
                    onPressed: () => navigatorPop(context: context),
                    child: const Text('Cancelar'),
                  ),
                  FlatButton(
                    onPressed: () {
                      context.read<Section>().removeItem(item);
                      navigatorPop(context: context);
                    },
                    child: const Text('Excluir'),
                  ),
                  _flatButtonVincularDesvincular(context, product)
                ],
              ));
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

  Widget _flatButtonVincularDesvincular(BuildContext context, Product product) {
    if (product != null) {
      return FlatButton(
        onPressed: () {
          item.product = null;
          navigatorPop(context: context);
        },
        child: const Text('Desvincular'),
      );
    } else {
      return FlatButton(
        onPressed: () async {
          final Product product = await navigatorPush(context, SelectProductScreen());
          item.product = product?.id;
          navigatorPop(context: context);
        },
        child: const Text('Vincular'),
      );
    }
  }
}
