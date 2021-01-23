import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/estabelecimentos.dart';

class EstabListTile extends StatelessWidget {
  final Estabelecimentos estabelecimentos;
  const EstabListTile(this.estabelecimentos);

  @override
  Widget build(BuildContext context) {
    bool hasNavigation =true;
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height:60,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).backgroundColor),
          child: Row(
            children: [
              /*AspectRatio(
                aspectRatio: 1,
                child: Image.network(estabelecimentos.image),
              ),*/
              //SizedBox(width: kSpacingUnit.w * 2.5,),
              Text(
                estabelecimentos.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 16)
              ),
              const Spacer(),
              if (hasNavigation)
               const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
