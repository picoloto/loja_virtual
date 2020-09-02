import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/home/home_manager.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Home"),
              centerTitle: true,
            ),
          ),
          Consumer<HomeManager>(builder: (_, manager, __) {
            final List<Widget> children = manager.sections.map<Widget>((e) {
              switch (e.type) {
                case 'list':
                  return SectionList(e);
                case 'staggered':
                  return SectionStaggered(e);
                default:
                  return Container();
              }
            }).toList();

            return SliverList(
              delegate: SliverChildListDelegate(children),
            );
          })
        ],
      ),
    );
  }
}
