import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_loader_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/models/product/product_manager.dart';
import 'package:loja_virtual/screens/product/components/images_form.dart';
import 'package:loja_virtual/screens/product/components/versions_form.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bool editing;

  EditProductScreen(Product p)
      : editing = p?.id != null,
        product = p.clone();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Produto' : 'Novo Produto'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              ImagesForm(product),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        initialValue: product.name,
                        decoration: const InputDecoration(
                          labelText: 'Nome do produto',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (name) => product.name = name,
                        validator: (name) =>
                            name.length < 6 ? 'Nome muito curto' : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        initialValue: product.description,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null,
                        onSaved: (description) =>
                            product.description = description,
                        validator: (description) => description.length < 10
                            ? 'Descrição muito curta'
                            : null,
                      ),
                    ),
                    VersionsForm(product),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Consumer<Product>(builder: (_, product, __) {
                        return !product.loading
                            ? CustomRaisedButton(
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    await product.save();
                                    context.read<ProductManager>().update(product);

                                    navigatorPop(context: context);
                                  }
                                },
                                child:
                                    const CustomTextFromRaisedButton('Salvar'),
                              )
                            : CustomLoaderRaisedButton();
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
