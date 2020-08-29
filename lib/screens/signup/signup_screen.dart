import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_raised_button.dart';
import 'package:loja_virtual/common/custom_raised_button/custom_text_from_raised_button.dart';
import 'package:loja_virtual/common/loading_from_button.dart';
import 'package:loja_virtual/models/user/user.dart';
import 'package:loja_virtual/models/user/user_manager.dart';
import 'package:loja_virtual/utils/navigator.dart';
import 'package:loja_virtual/utils/validators.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar conta', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    enabled: !userManager.loading,
                    autocorrect: false,
                    validator: (nome) => _validaNome(nome),
                    decoration: const InputDecoration(
                      labelText: 'Nome Completo',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (nome) => user.name = nome,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    enabled: !userManager.loading,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) => _validaEmail(email),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (email) => user.email = email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    enabled: !userManager.loading,
                    autocorrect: false,
                    obscureText: true,
                    validator: (senha) => _validaSenha(senha),
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (senha) => user.password = senha,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    enabled: !userManager.loading,
                    autocorrect: false,
                    obscureText: true,
                    validator: (confirmacaoSenha) =>
                        _validaSenha(confirmacaoSenha),
                    decoration: const InputDecoration(
                      labelText: 'Repita a Senha',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (confirmacaoSenha) =>
                        user.confirmPassword = confirmacaoSenha,
                  ),
                  const SizedBox(height: 16),
                  CustomRaisedButton(
                    onPressed: userManager.loading
                        ? null
                        : () => _cadastrar(userManager, context),
                    child: userManager.loading
                        ? LoadingFromButton()
                        : const CustomTextFromRaisedButton('Criar Conta'),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  String _validaEmail(String email) {
    if (email.isEmpty) {
      return 'Campo Obrigatório';
    } else if (!emailValid(email)) {
      return 'Email Inválido';
    }
    return null;
  }

  String _validaSenha(String senha) {
    if (senha.isEmpty) {
      return 'Campo Obrigatório';
    } else if (senha.length < 6) {
      return 'Senha muito curta (minimo 6 caracteres)';
    }
    return null;
  }

  String _validaNome(String nome) {
    if (nome.isEmpty) {
      return 'Campo Obrigatório';
    } else if (nome.trim().split(' ').length <= 1) {
      return 'Preencha seu Nome Completo';
    }
    return null;
  }

  void _cadastrar(UserManager userManager, BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      if (user.password != user.confirmPassword) {
        scaffoldKey.currentState.showSnackBar(const SnackBar(
          content: Text('Senha repetida diferente da senha informada!'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      userManager.signUp(
          user: user,
          onSuccess: () {
            navigatorPop(context: context);
          },
          onFail: (e) {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Falha ao criar conta: $e'),
              backgroundColor: Colors.red,
            ));
          });
    }
  }
}
