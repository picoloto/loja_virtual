import 'package:flutter/material.dart';
import 'package:loja_virtual/manager/home_manager.dart';
import 'package:loja_virtual/models/home/section.dart';

class AddSectionWidget extends StatelessWidget {
  final HomeManager homeManager;

  const AddSectionWidget(this.homeManager);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlatButton(
            onPressed: () => homeManager.addSection(Section(type: 'list')),
            textColor: Colors.black,
            child: const Text('Adicionar Seção'),
          ),
        )
      ],
    );
  }
}
