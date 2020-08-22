import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          DrawerTile(
            icon: Icons.home,
            title: 'Home',
            page: 0,
          ),
          DrawerTile(
            icon: Icons.format_list_bulleted,
            title: 'Produtos',
            page: 1,
          ),
          DrawerTile(
            icon: Icons.playlist_add_check,
            title: 'Pedidos',
            page: 2,
          ),
          DrawerTile(
            icon: Icons.location_on,
            title: 'Lojas',
            page: 3,
          ),
        ],
      ),
    );
  }
}
