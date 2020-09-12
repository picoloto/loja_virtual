import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_error_text.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/product/product_version.dart';
import 'package:loja_virtual/screens/product/components/edit_product_version.dart';
import 'package:loja_virtual/screens/product/components/position_version_enum.dart';

class VersionsForm extends StatelessWidget {
  final Product product;

  const VersionsForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ProductVersion>>(
      initialValue: product.versions,
      validator: (versions) => versions.isEmpty ? 'Insira uma versão!' : null,
      builder: (state) {
        return Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Versões',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Colors.black,
                      onTap: () {
                        state.value.add(ProductVersion());
                        state.didChange(state.value);
                      },
                    )
                  ],
                )),
            Column(
              children: state.value
                  .map((version) => EditProductVersion(
                        key: ObjectKey(version),
                        version: version,
                        onRemove: () {
                          state.value.remove(version);
                          state.didChange(state.value);
                        },
                        onMoveUp: version != state.value.first
                            ? () => _moveVersion(
                                state, PositionVersionEnum.up, version)
                            : null,
                        onMoveDown: version != state.value.last
                            ? () => _moveVersion(
                                state, PositionVersionEnum.down, version)
                            : null,
                      ))
                  .toList(),
            ),
            _errorContainer(state),
          ],
        );
      },
    );
  }

  void _moveVersion(FormFieldState<List<ProductVersion>> state,
      PositionVersionEnum position, ProductVersion version) {
    final index = state.value.indexOf(version);
    final positionIndex =
        position == PositionVersionEnum.up ? index - 1 : index + 1;
    state.value.remove(version);
    state.value.insert(positionIndex, version);
    state.didChange(state.value);
  }

  Widget _errorContainer(FormFieldState<List<ProductVersion>> state) {
    return state.hasError
        ? CustomErrorText(
            text: state.errorText,
            fontSize: 12,
            alignment: Alignment.centerLeft,
          )
        : Container();
  }
}
