import 'package:flutter/material.dart';
import 'package:loja_virtual/common/app_primary_color.dart';
import 'package:loja_virtual/manager/page_manager.dart';

import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final int page;

  const DrawerTile({this.icon, this.title, this.page});

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().currentPage;
    final primaryColor = appPrimaryColor(context);

    return ListTile(
      leading: Icon(
        icon,
        size: 32,
        color: curPage == page ? primaryColor : Colors.grey[700],
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: curPage == page ? primaryColor : Colors.grey[700],
        ),
      ),
      onTap: () => {context.read<PageManager>().setPage(page)},
    );
  }
}
