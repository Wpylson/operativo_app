import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/custom_icon_button.dart';
import 'package:operativo_final_cliente/models/home_manager.dart';
import 'package:operativo_final_cliente/models/section.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();

     if(homeManager.editing){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: section.name,
                    decoration: const InputDecoration(
                      hintText: 'Digite o Título aqui',
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18
                    ),
                    onChanged: (text) => section.name = text,
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.delete,
                  color: Colors.white,
                  onTap: (){
                    homeManager.removeSection(section);
                  },
                )
              ],
            ),
            if(section.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  section.error,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
          ],
        );
     }else{
       return Padding(
         padding: const EdgeInsets.symmetric(vertical:8.0),
         child: Text(section.name,
           style: const TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.w800,
               fontSize: 18
           ),
         ),
       );
     }

  }
}
