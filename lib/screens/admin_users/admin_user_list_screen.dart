import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/user/admin_user_manager.dart';
import 'package:provider/provider.dart';

class AdminUserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUserManager>(
        builder: (_, manager, __){
          return AlphabetListScrollView(
            itemBuilder: (_, index){
              return ListTile(
                title: Text(manager.users[index].name),
                subtitle: Text(manager.users[index].email),
              );
            },
            indexedHeight: (index) => 80,
            strList: manager.names,
            showPreview: true,
            highlightTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          );
        },
      ),
    );
  }
}
