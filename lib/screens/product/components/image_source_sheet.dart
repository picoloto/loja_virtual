import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({this.onImageSelect});

  final Function(File) onImageSelect;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BottomSheet(
      onClosing: () {},
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: primaryColor),
            title: const Text('Camera'),
            onTap: () async => _selectFile(ImageSource.camera),
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: primaryColor),
            title: const Text('Galeria'),
            onTap: () async => _selectFile(ImageSource.gallery),
          )
        ],
      ),
    );
  }

  Future<void> _selectFile(ImageSource imageSource) async {
    final PickedFile pickedFile = await picker.getImage(source: imageSource);
    _editImage(pickedFile.path);
  }

  Future<void> _editImage(String path) async {
    final File croppedFile = await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
      ),
      iosUiSettings: const IOSUiSettings(
          title: 'Editar Imagem',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir'),
    );

    if (croppedFile != null) {
      onImageSelect(croppedFile);
    }
  }
}
