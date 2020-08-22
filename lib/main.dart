import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja do Leandro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen(),
//        initialRoute: '/base',
//        onGenerateRoute: (settings) {
//          switch (settings.name) {
//            case '/signup':
//              return MaterialPageRoute(builder: (_) => SignUpScreen());
//            case '/base':
//            default:
//              return MaterialPageRoute(builder: (_) => BaseScreen());
//          }
//        },
      ),
    );
  }
}
