import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/services.dart';

class ServiceTile extends StatelessWidget {
  final Services services;
  const ServiceTile(this.services);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/services', arguments: services);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(services.icon),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(services.title,
                    style: const TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16
                    ) ,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
