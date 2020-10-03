import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart/cart_manager.dart';
import 'package:loja_virtual/models/home/home_manager.dart';
import 'package:loja_virtual/models/product/product_manager.dart';
import 'package:loja_virtual/models/user/admin_user_manager.dart';
import 'package:loja_virtual/models/user/user_manager.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUserManager>(
          create: (_) => AdminUserManager(),
          update: (_, userManager, adminUserManager) =>
          adminUserManager..updateUser(userManager),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Loja do Leandro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: const TextTheme(
              headline6: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            color: Colors.white24,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        home: BaseScreen(),
      ),
    );
  }
}
