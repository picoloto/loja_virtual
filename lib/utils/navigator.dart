import 'package:flutter/material.dart';

Future<T> navigatorPush<T extends Object>(BuildContext context, Widget page) {
  return Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

void navigatorPop({BuildContext context, dynamic params}){
  if(params != null){
    Navigator.of(context).pop(params);
  }else{
    Navigator.of(context).pop();
  }

}