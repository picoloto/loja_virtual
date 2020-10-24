import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual/manager/user_manager.dart';

import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          CustomDrawerHeader(),
          const DrawerTile(
            icon: Icons.home,
            title: 'Home',
            page: 0,
          ),
          const DrawerTile(
            icon: Icons.storage,
            title: 'Produtos',
            page: 1,
          ),
          const DrawerTile(
            icon: Icons.assignment,
            title: 'Pedidos',
            page: 2,
          ),
          const DrawerTile(
            icon: Icons.location_on,
            title: 'Lojas',
            page: 3,
          ),
          Consumer<UserManager>(
            builder: (_, manager, __){
              if(manager.adminEnabled){
                return _adminSection();
              }else{
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _adminSection() {
    return Column(
      children: const [
        Divider(),
        DrawerTile(
          icon: Icons.people,
          title: 'Usuários',
          page: 4,
        ),
        DrawerTile(
          icon: Icons.playlist_add_check,
          title: 'Produtos',
          page: 5,
        ),
      ],
    );
  }
}
