import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/models/user/user_manager.dart';
import 'package:loja_virtual/screens/admin_users/admin_user_list_screen.dart';
import 'package:loja_virtual/screens/home/home_screen.dart';
import 'package:loja_virtual/screens/product/product_list_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, manager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductListScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(title: const Text('Pedidos')),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(title: const Text('Lojas')),
              ),
              if (manager.adminEnabled)
                ...[
                  AdminUserListScreen(),
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(title: const Text('Pedidos')),
                  ),
                ]
            ],
          );
        },
      ),
    );
  }
}
