import 'package:flutter/material.dart';
import 'package:loja_virtual/common/app_primary_color.dart';
import 'package:loja_virtual/manager/page_manager.dart';
import 'package:loja_virtual/manager/user_manager.dart';

import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      height: 160,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Loja Virtual',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              Text(
                'Olá ${userManager.user?.name ?? ''}!',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 18, ),
              ),
              GestureDetector(
                onTap: (){
                  if(userManager.isLoggedIn){
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                    navigatorPush(context, LoginScreen());
                  }else{
                    navigatorPush(context, LoginScreen());
                  }
                },
                child: Text(
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou Cadastre-se',
                  style: TextStyle(
                    color: appPrimaryColor(context),
                    fontSize: 16,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
