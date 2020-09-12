import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product/product.dart';
import 'package:loja_virtual/screens/product/components/image_source_sheet.dart';
import 'package:loja_virtual/utils/navigator.dart';

class ImagesForm extends StatelessWidget {
  final Product product;

  const ImagesForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (images) =>
          images.isEmpty ? 'Insira ao menos uma imagem' : null,
      builder: (state) {
        return Container(
          height: 450,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images: state.value.map((e) => _stackImage(state, e)).toList()
                    ..add(_newImageButton(context, state)),
                  dotSize: 4,
                  borderRadius: true,
                  radius: const Radius.circular(4),
                  dotBgColor: Colors.transparent,
                  autoplay: false,
                  dotSpacing: 15,
                ),
              ),
              _errorText(state)
            ],
          ),
        );
      },
    );
  }

  Widget _stackImage(FormFieldState<List<dynamic>> state, dynamic image) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _widgetImage(image),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 48,
            height: 48,
            color: Colors.red,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            splashColor: Colors.white.withOpacity(0.25),
            color: Colors.white,
            onPressed: () {
              state.value.remove(image);
              state.didChange(state.value);
            },
            icon: const Icon(Icons.delete),
          ),
        )
      ],
    );
  }

  Widget _widgetImage(image) {
    return image is String
        ? Image.network(image, fit: BoxFit.cover)
        : Image.file(image as File, fit: BoxFit.cover);
  }

  Widget _newImageButton(BuildContext context, FormFieldState<List> state) {
    return Material(
      color: Colors.grey[200],
      child: IconButton(
        icon: const Icon(Icons.add_a_photo),
        color: Theme.of(context).primaryColor,
        iconSize: 50,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => ImageSourceSheet(
              onImageSelect: (file) {
                state.value.add(file);
                state.didChange(state.value);
                navigatorPop(context: context);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _errorText(FormFieldState<List> state) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      alignment: Alignment.centerLeft,
      child: Text(state.errorText ?? '',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
      ),
    );
  }
}
