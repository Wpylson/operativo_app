import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/helpers/validators.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/base/home_base_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: azul,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: azul,
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: Text(
              'Criar Conta',
              style: TextStyle(fontSize: 14, color: amarela),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: Text(
                    "Bem-vindo \nde volta ",
                    style: TextStyle(color: amarela, fontSize: 32),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70.0,
            ),
            Center(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                color: branco,
                child: Form(
                  key: formKey,
                  child: Consumer<UserManager>(
                    builder: (_, userManager, child) {
                      return ListView(
                        padding: const EdgeInsets.all(16.0),
                        shrinkWrap: true,
                        children: [
                          TextFormField(
                            controller: emailController,
                            enabled: !userManager.loading,
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              prefixIcon: Icon(Icons.mail, color: azul),
                              hintStyle: TextStyle(color: azul),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (email) {
                              if (!emailValid(email)) {
                                return "E-mail inválido!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: passController,
                            enabled: !userManager.loading,
                            decoration: InputDecoration(
                              hintText: 'Palavra-passe',
                              prefixIcon: Icon(Icons.lock, color: azul),
                              hintStyle: TextStyle(color: azul),
                            ),
                            obscureText: true,
                            autocorrect: false,
                            validator: (pass) {
                              if (pass.isEmpty || pass.length < 6) {
                                return 'Palavra-passe inválida';
                              }
                              return null;
                            },
                          ),
                          child,
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: userManager.loading
                                  ? null
                                  : () {
                                      if (formKey.currentState.validate()) {
                                        userManager.signIn(
                                          user: User(
                                            email: emailController.text.trim(),
                                            password:
                                                passController.text.trim(),
                                          ),
                                          onFail: (e) {
                                            scaffoldKey.currentState
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('Falha ao entrar: $e'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          },
                                          onSuccess: () {
                                            // Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeBaseScreen(),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: azul,
                                textStyle: TextStyle(color: amarela),
                              ),
                              disabledColor: primaryColor.withAlpha(100),
                              child: userManager.loading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          ),
                        ],
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueci-me a minha palavra-passe',
                          style: TextStyle(color: azul),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
