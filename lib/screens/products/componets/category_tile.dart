import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/categorys.dart';

class CategoryTile extends StatelessWidget {
  final Category category;

  const CategoryTile(this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/category', arguments: category);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(category.icon),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 16)),
                    ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
