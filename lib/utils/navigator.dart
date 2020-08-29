import 'package:flutter/material.dart';

void navigatorPush(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

void navigatorPop({BuildContext context, dynamic params}){
  if(params != null){
    Navigator.of(context).pop(params);
  }else{
    Navigator.of(context).pop();
  }

}