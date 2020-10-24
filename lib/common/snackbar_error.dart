import 'package:flutter/material.dart';

void snackBarError(BuildContext context, String textError) => Scaffold.of(context).showSnackBar(
  SnackBar(
    content: Text(textError),
    backgroundColor: Colors.red[700],
  )
);