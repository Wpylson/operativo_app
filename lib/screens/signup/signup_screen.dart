import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/helpers/validators.dart';
import 'package:operativo_final_cliente/models/user.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/base/home_base_screen.dart';
import 'package:operativo_final_cliente/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: azul,
        appBar: AppBar(
          title: Text(
            'Criar Conta',
            style: TextStyle(color: amarela),
          ),
          centerTitle: true,
          backgroundColor: azul,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: amarela,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }),
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
                      "Digite \nos seus dados ",
                      style: TextStyle(color: amarela, fontSize: 32),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              Center(
                child: Card(
                  color: amarela,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: formKey,
                    child: Consumer<UserManager>(
                      builder: (_, userManager, __) {
                        return ListView(
                          padding: const EdgeInsets.all(16),
                          shrinkWrap: true,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Nome Completo',
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: azul,
                                  ),
                                hintStyle: TextStyle(color: azul)
                              ),
                              enabled: !userManager.loading,
                              validator: (name) {
                                if (name.isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (name.trim().split(' ').length <= 1) {
                                  return 'Preencha seu Nome Completo';
                                }
                                return null;
                              },
                              onSaved: (name) => user.name = name,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'E-mail',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: azul,
                                  ),
                                  hintStyle: TextStyle(color: azul)),
                              enabled: !userManager.loading,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (email) {
                                if (email.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                if (!emailValid(email)) {
                                  return "E-mail inválido!";
                                }
                                return null;
                              },
                              onSaved: (email) => user.email = email,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  hintText: 'Palavra-passe',
                              prefixIcon: Icon(Icons.lock,color:azul),
                              hintStyle: TextStyle(color:azul)),
                              enabled: !userManager.loading,
                              obscureText: true,
                              validator: (pass) {
                                if (pass.isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (pass.length < 6) {
                                  return 'Palavra-passe muito curta';
                                }
                                return null;
                              },
                              onSaved: (pass) => user.password = pass,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  hintText: 'Repita a palavra-passe',
                                  prefixIcon: Icon(Icons.lock,color:azul),
                                  hintStyle: TextStyle(color:azul)),
                              enabled: !userManager.loading,
                              obscureText: true,
                              validator: (confirmPass) {
                                if (confirmPass.isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (confirmPass.length < 6) {
                                  return 'Palavra-passe muito curta';
                                }
                                return null;
                              },
                              onSaved: (confirmPass) =>
                                  user.confirmPassword = confirmPass,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 44,
                              child: RaisedButton(
                                color: azul,
                                disabledColor: primaryColor.withAlpha(100),
                                textColor: amarela,
                                onPressed: userManager.loading
                                    ? null
                                    : () {
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();

                                          if (user.password !=
                                              user.confirmPassword) {
                                            scaffoldKey.currentState
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Senhas não coincidem!'),
                                              backgroundColor: Colors.red,
                                            ));
                                            return;
                                          }
                                          userManager.signUp(
                                              user: user,
                                              onSuccess: () {
                                                Navigator.of(context).pop();
                                              },
                                              onFail: (e) {
                                                scaffoldKey.currentState
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Falha ao cadastrar: $e'),
                                                  backgroundColor: Colors.red,
                                                ));
                                              });
                                        }
                                      },
                                child: userManager.loading
                                    ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation(Color.fromRGBO( 255, 207, 1,1.0)),
                                      )
                                    : const Text(
                                        'Criar Conta',
                                        style: TextStyle(fontSize: 18),
                                      ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
