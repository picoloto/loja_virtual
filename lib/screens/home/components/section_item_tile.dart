import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductById(item.product);
          if (product != null) {
            navigatorPush(context, ProductScreen(product));
          }
        }
      },
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.image,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}