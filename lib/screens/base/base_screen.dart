import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/manager/page_manager.dart';
import 'package:loja_virtual/manager/user_manager.dart';
import 'package:loja_virtual/screens/admin_users/admin_user_list_screen.dart';
import 'package:loja_virtual/screens/home/home_screen.dart';
import 'package:loja_virtual/screens/orders/orders_screen.dart';
import 'package:loja_virtual/screens/product/product_list_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
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
              OrdersScreen(),
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
