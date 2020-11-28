import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/page_manager.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (_, userManager,__){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            const  Text(
                'Operativo',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8,),
              Text('Olá, ${userManager.user?.name?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(userManager.isLoggedIn){
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                  }else{
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn
                      ? 'Sair'
                      : 'Entre ou cadastra-se >',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
