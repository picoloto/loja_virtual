import 'package:flutter/material.dart';

void navigatorPush(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

void navigatorPop(BuildContext context){
  Navigator.of(context).pop();
}