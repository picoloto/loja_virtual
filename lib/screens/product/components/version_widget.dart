import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/product/product_version.dart';
import 'package:provider/provider.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({this.version});

  final ProductVersion version;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = version == product.selectedVersion;
    Color color;
    if(!version.hasStock){
      color = Colors.red.withAlpha(50);
    }else if(selected){
      color = Theme.of(context).primaryColor;
    }else{
      color = Colors.grey;
    }

    return InkWell(
      onTap: !version.hasStock ? null : (){
        product.selectedVersion = version;
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                version.name,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Text(
                'R\$ ${version.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                  fontSize: 16
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
