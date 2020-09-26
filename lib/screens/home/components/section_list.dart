import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home/home_manager.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:loja_virtual/screens/home/components/add_section_tile_widget.dart';
import 'package:loja_virtual/screens/home/components/section_header.dart';
import 'package:loja_virtual/screens/home/components/section_item_tile.dart';
import 'package:provider/provider.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(section),
            SizedBox(
              height: 150,
              child: Consumer<Section>(
                builder: (_, manager, __){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => AspectRatio(
                      aspectRatio: 1,
                      child: index < section.items.length
                          ? SectionItemTile(section.items[index])
                          : AddSectionTileWidget(section),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 4),
                    itemCount: homeManager.editing
                        ? section.items.length + 1
                        : section.items.length,
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
