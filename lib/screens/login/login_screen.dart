import 'package:flutter/material.dart';
import 'package:loja_virtual/common/loading_for_button/loading_for_button.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:loja_virtual/utils/validators.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          FlatButton(
            //onPressed: () => Navigator.of(context).pushReplacementNamed('/signup');
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUpScreen())),
            child: const Text('CRIAR CONTA'),
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) => _validaEmail(email),
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: senhaController,
                      enabled: !userManager.loading,
                      autocorrect: false,
                      obscureText: true,
                      validator: (senha) => _validaSenha(senha),
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text('Esqueci minha senha'),
                      ),
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading
                            ? null
                            : () => login(userManager),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: colorPrimary,
                        textColor: Colors.white,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(120),
                        child: userManager.loading
                            ? LoadingForButton()
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void login(UserManager userManager) {
    if (formKey.currentState.validate()) {
      final User user =
          User(email: emailController.text, password: senhaController.text);
      userManager.signIn(
          user: user,
          onFail: (e) {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Falha ao entrar: $e'),
              backgroundColor: Colors.red,
            ));
          },
          onSuccess: () {
            // TODO FECHAR TELA DE LOGIN
          });
    }
  }

  String _validaSenha(String senha) {
    if (senha.isEmpty || senha.length < 6) {
      return 'Senha Inválida';
    }
    return null;
  }

  String _validaEmail(String email) {
    if (!emailValid(email)) {
      return 'Email Inválido';
    }
    return null;
  }
}