import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/helpers/validators.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/base/home_base_screen.dart';
import 'package:operativo_final_cliente/screens/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:operativo_final_cliente/models/user.dart';

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
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: const Text('Criar Conta',
              style:TextStyle(fontSize: 14) ,),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager,child){
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if(!emailValid(email)){
                          return "E-mail inválido!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Palavra-passe'),
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
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading ? null :() {
                          if(formKey.currentState.validate()){
                            userManager.signIn(
                                user: User(
                                  email: emailController.text.trim(),
                                  password: passController.text.trim(),
                                ),
                                onFail:(e){
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Falha ao entrar: $e'),
                                        backgroundColor: Colors.red,
                                      )
                                  );
                                },
                                onSuccess: (){
                                 // Navigator.of(context).pop();
                                  Navigator.push(context, MaterialPageRoute( builder: (context)=>HomeBaseScreen()));
                                }
                            );
                          }
                        },
                        color: primaryColor,
                        disabledColor: primaryColor.withAlpha(100),
                        textColor: Colors.white ,
                        child:userManager.loading ?
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ): const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18),),
                      ),
                    ),
                  ],
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: const Text('Esqueci-me a minha palavra-passe '),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
