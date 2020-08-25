import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/user/user_manager.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';

import 'components/version_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.all(12),
              child: AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images: product.images.map((e) => NetworkImage(e)).toList(),
                  dotSize: 4,
                  borderRadius: true,
                  radius: const Radius.circular(4),
                  dotBgColor: Colors.transparent,
                  autoplay: false,
                  dotSpacing: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    subtitle: const Text('A partir de'),
                    trailing: Text(
                      'R\$ 19.99',
                      style: TextStyle(
                          fontSize: 22,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(product.description),
                  const SizedBox(height: 14),
                  const Text(
                    'Versões',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.versions.map((e) {
                      return VersionWidget(version: e);
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Consumer2<UserManager, Product>(
                      builder: (_, userManager, productManager, __) {
                    if (product.hasStock) {
                      return _botaoAdicionarAoCarrinho(
                          userManager, context, primaryColor);
                    } else {
                      return _botaoSemEstoque();
                    }
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _botaoAdicionarAoCarrinho(
      UserManager userManager, BuildContext context, Color primaryColor) {
    return SizedBox(
      height: 44,
      child: RaisedButton(
        onPressed: product.selectedVersion == null
            ? null
            : () {
                if (userManager.isLoggedIn) {
                  // TODO ADICIONAR AO CARRINHO
                } else {
                  navigatorPush(context, LoginScreen());
                }
              },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: primaryColor,
        textColor: Colors.white,
        disabledColor: primaryColor.withAlpha(120),
        child: Text(
          userManager.isLoggedIn
              ? 'ADICIONAR AO CARRINHO'
              : 'ENTRE PARA COMPRAR',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _botaoSemEstoque() {
    return SizedBox(
      height: 44,
      child: RaisedButton(
        onPressed: null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        disabledColor: Colors.red,
        disabledTextColor: Colors.white,
        child: const Text(
          'PRODUTO SEM ESTOQUE',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
