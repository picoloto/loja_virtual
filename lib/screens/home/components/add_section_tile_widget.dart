import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:loja_virtual/models/home/section_item.dart';
import 'package:loja_virtual/screens/product/components/image_source_sheet.dart';
import 'package:loja_virtual/utils/navigator.dart';

class AddSectionTileWidget extends StatelessWidget {
  final Section section;

  const AddSectionTileWidget(this.section);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: (){
          showModalBottomSheet(
            context: context,
            builder: (_) => ImageSourceSheet(
              onImageSelect: (file) {
                section.addItem(SectionItem(image: file));
                navigatorPop(context: context);
              },
            ),
          );
        },
        child: Container(
          color: Colors.black.withAlpha(90),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
