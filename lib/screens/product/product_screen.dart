import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/models/cart/cart_manager.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/user/user_manager.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/product/edit_product_screen.dart';
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
          actions: [
            Consumer<UserManager>(
              builder: (_, manager, __) {
                return !manager.adminEnabled
                    ? Container()
                    : _iconButtonEditarProduto(context, product);
              },
            )
          ],
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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Text(product.description),
                  ),
                  _versionSection(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Consumer2<UserManager, Product>(
                        builder: (_, userManager, productManager, __) {
                      if (product.hasStock) {
                        return _botaoAdicionarAoCarrinho(
                            userManager, context, primaryColor);
                      } else {
                        return _botaoSemEstoque();
                      }
                    }),
                  )
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
    return CustomRaisedButton(
      onPressed: product.selectedVersion == null
          ? null
          : () {
              if (userManager.isLoggedIn) {
                context.read<CartManager>().addToCart(product);
                navigatorPush(context, CartScreen());
              } else {
                navigatorPush(context, LoginScreen());
              }
            },
      child: CustomTextFromRaisedButton(userManager.isLoggedIn
          ? 'ADICIONAR AO CARRINHO'
          : 'ENTRE PARA COMPRAR'),
    );
  }

  Widget _botaoSemEstoque() {
    return const CustomRaisedButton(
      child: CustomTextFromRaisedButton('PRODUTO SEM ESTOQUE'),
    );
  }

  Widget _iconButtonEditarProduto(BuildContext context, Product product) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        navigatorPush(context, EditProductScreen(product));
      },
    );
  }

  Widget _versionSection() {
    if (product.versions.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Versões',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) =>
                    VersionWidget(version: product.versions[index]),
                itemCount: product.versions.length,
              ),
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
