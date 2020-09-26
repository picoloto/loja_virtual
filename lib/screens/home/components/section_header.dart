import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/home/home_manager.dart';
import 'package:loja_virtual/models/home/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  final Section section;

  const SectionHeader(this.section);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    if (homeManager.editing) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: section.name ?? '',
                decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                    isDense: true),
                onChanged: (text) => section.name = text,
              ),
            ),
            CustomIconButton(
              iconData: Icons.remove,
              color: Colors.black,
              onTap: () => homeManager.removeSection(section),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          section.name ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      );
    }
  }
}
