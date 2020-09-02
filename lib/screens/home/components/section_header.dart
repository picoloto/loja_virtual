import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home/section.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      ),
    );
  }
}
