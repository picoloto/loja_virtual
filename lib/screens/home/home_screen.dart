import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/common/app_primary_color.dart';
import 'package:loja_virtual/manager/home_manager.dart';
import 'package:loja_virtual/manager/user_manager.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/home/components/add_section_widget.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            elevation: 0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Home"),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () => navigatorPush(context, CartScreen()),
                icon: const Icon(Icons.shopping_cart),
              ),
              Consumer2<UserManager, HomeManager>(
                builder: (_, userManager, homeManager, __) =>
                    _editButton(context, userManager, homeManager),
              )
            ],
          ),
          Consumer<HomeManager>(builder: (_, manager, __) {
            if(manager.loading){
              return SliverToBoxAdapter(
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(appPrimaryColor(context)),
                  backgroundColor: Colors.transparent,
                ),
              );
            }

            final List<Widget> children =
                manager.sections.map<Widget>((e) => SectionList(e)).toList();

            if (manager.editing) {
              children.add(AddSectionWidget(manager));
            }

            return SliverList(
              delegate: SliverChildListDelegate(children),
            );
          })
        ],
      ),
    );
  }

  Widget _editButton(
      BuildContext context, UserManager userManager, HomeManager homeManager) {
    if (userManager.adminEnabled && !homeManager.loading) {
      return homeManager.editing
          ? _popupMenu(context, userManager, homeManager)
          : IconButton(
              icon: const Icon(Icons.edit),
              onPressed: homeManager.enterEditing);
    } else {
      return Container();
    }
  }

  Widget _popupMenu(
      BuildContext context, UserManager userManager, HomeManager homeManager) {
    return PopupMenuButton(
      onSelected: (e) => e == 'Salvar'
          ? homeManager.saveEditing()
          : homeManager.discardEditing(),
      itemBuilder: (_) {
        return ['Salvar', 'Descartar']
            .map((e) => PopupMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList();
      },
    );
  }
}
