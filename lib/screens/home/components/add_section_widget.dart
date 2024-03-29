import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/home_manager.dart';
import 'package:operativo_final_cliente/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget(this.homeManager);
  final HomeManager homeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FlatButton(
              onPressed: (){
                homeManager.addSection(Section(type: 'List'));
              },
              textColor: Colors.white,
              child: const Text('Adicionar Lista'),
            )
        ),
        Expanded(
            child: FlatButton(
              onPressed: (){
                homeManager.addSection(Section(type: 'Staggered'));
              },
              textColor: Colors.white,
              child: const Text('Adicionar Grade'),
            )
        )
      ],
    );
  }
}
