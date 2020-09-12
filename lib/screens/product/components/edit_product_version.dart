import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/product/product_version.dart';

class EditProductVersion extends StatelessWidget {
  final ProductVersion version;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const EditProductVersion(
      {Key key, this.version, this.onRemove, this.onMoveUp, this.onMoveDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 25,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextFormField(
              initialValue: version.name,
              decoration: const InputDecoration(
                  labelText: 'Sigla',
                  border: OutlineInputBorder(),
                  isDense: true),
              validator: (name) => name.isEmpty ? 'Inválido' : null,
              onChanged: (name) => version.name = name,
            ),
          ),
        ),
        Expanded(
          flex: 35,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextFormField(
              initialValue: version.stock?.toString(),
              decoration: const InputDecoration(
                  labelText: 'Estoque',
                  border: OutlineInputBorder(),
                  isDense: true),
              keyboardType: TextInputType.number,
              validator: (stock) =>
                  int.tryParse(stock) == null ? 'Inválido' : null,
              onChanged: (stock) => version.stock = int.tryParse(stock),
            ),
          ),
        ),
        Expanded(
          flex: 40,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TextFormField(
              initialValue: version.price?.toStringAsFixed(2),
              decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                  prefixText: 'R\$ ',
                  isDense: true),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (price) =>
                  num.tryParse(price) == null ? 'Inválido' : null,
              onChanged: (price) => version.price = num.tryParse(price),
            ),
          ),
        ),
        CustomIconButton(
          iconData: Icons.delete,
          color: Colors.black,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.keyboard_arrow_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.keyboard_arrow_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
