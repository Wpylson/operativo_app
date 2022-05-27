import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';

class AnythingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: amarela,
      appBar: AppBar(
        backgroundColor: amarela,
        elevation: 0.0,
        title: Text(
          "Qualquer Coisa",
          style: TextStyle(color: azul),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: azul,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey[100],
                        height: 110.0,
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Diz-no em detalhes aquilo de"
                                " \nque precisas",
                                style: TextStyle(fontSize: 20.0, color: preto),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Se cabe na nossa mochila, podemos \n entrega-lo",
                                style: TextStyle(fontSize: 15.0, color: preto),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: branco,
                        height: 200.0,
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText:
                                  'Toque aqui para escrever...\n Onde ? referencia?',
                              border: InputBorder.none),
                          style:
                              const TextStyle(decoration: TextDecoration.none),
                          maxLines: null,
                          maxLength: 255,
                          expands: true,
                          cursorHeight: 20.0,
                          cursorColor: azul,
                        ),
                      )
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/checkout_anything');
                  },
                  child: Text(
                    'Seguinte',
                    style: TextStyle(color: amarela),
                  ),
                ),
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: azul,
                  size: 35.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
