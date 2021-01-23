import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/models/estabelecimentos_manager.dart';
import 'package:operativo_final_cliente/screens/estabelecimentos/components/estab_list_tile.dart';
import 'package:provider/provider.dart';

class EstabelecimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estabelecimentos'),
        centerTitle:true,
        elevation: 0,
        actions: [
           IconButton(
            icon: const Icon(Icons.update),
            onPressed: (){},
          )
        ],
      ),
      body: Consumer<EstabelecimentosManager>(
            builder: (_,estabManager,__){
              final filteredEstab = estabManager.filteredEstabs;
              if(filteredEstab.isNotEmpty){
                return ListView.builder(
                  itemCount: filteredEstab.length,
                  itemBuilder: (_,index){
                    return ListTile(
                      title: EstabListTile(
                       filteredEstab[index],
                      ),
                    );
                  },
                );
              }else{
                return const Center(
                  child: Text('Sem estabelecimentos!',
                  style: TextStyle(fontSize: 22.0,color:Colors.white),),
                );
              }
            },
          ),
    );
  }
}
