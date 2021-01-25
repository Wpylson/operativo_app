import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/helpers/validators.dart';
import 'package:operativo_final_cliente/models/user.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/base/home_base_screen.dart';
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
        appBar: AppBar(
          title: const Text('Criar Conta'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
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
                        decoration:
                            const InputDecoration(hintText: 'Nome Completo'),
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
                        decoration: const InputDecoration(hintText: 'E-mail'),
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
                        decoration:
                            const InputDecoration(hintText: 'Palavra-passe'),
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
                        decoration: const InputDecoration(
                            hintText: 'Repita a palavra-passe'),
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
                          color: primaryColor,
                          disabledColor: primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();

                                    if (user.password != user.confirmPassword) {
                                      scaffoldKey.currentState
                                          .showSnackBar(const SnackBar(
                                            content: Text('Senhas não coincidem!'),
                                            backgroundColor: Colors.red,
                                      ));
                                      return;
                                    }
                                    userManager.signUp(
                                        user: user,
                                        onSuccess: () {
                                          Navigator.push(context, MaterialPageRoute( builder: (context)=>SignUpScreen()));
                                        },
                                        onFail: (e) {
                                          scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Falha ao cadastrar: $e'),
                                            backgroundColor: Colors.red,
                                          ));
                                        });
                                  }
                                },
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
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
        ));
  }
}
