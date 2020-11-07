import 'package:flutter/material.dart';
import 'package:loja_virtual/common/app_primary_color.dart';

class LoadingFromCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(appPrimaryColor(context)),
      ),
    );
  }
}
