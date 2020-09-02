import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:loja_virtual/screens/home/components/section_header.dart';
import 'package:loja_virtual/screens/home/components/section_item_tile.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => AspectRatio(
                aspectRatio: 1,
                child: SectionItemTile(section.items[index]),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
