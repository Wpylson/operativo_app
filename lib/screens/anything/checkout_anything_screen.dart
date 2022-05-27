import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/common/date_time_picker.dart';
import 'package:operativo_final_cliente/common/drop_down_button.dart';
import 'package:operativo_final_cliente/common/price_selector.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class CheckoutAnythingScreen extends StatefulWidget {
  @override
  _CheckoutAnythingScreenState createState() => _CheckoutAnythingScreenState();
}

class _CheckoutAnythingScreenState extends State<CheckoutAnythingScreen> {
  final PanelController panelController = PanelController();
  String payMethod;
  Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: amarela,
      appBar: AppBar(
        backgroundColor: amarela,
        title: Text(
          "Checkout",
          style: TextStyle(color: azul),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: azul,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: branco,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        color: branco,
                        //height: 200.0,
                        margin: const EdgeInsets.all(0),
                        alignment: Alignment.centerLeft,
                        child: ExpansionTile(
                          leading: Icon(
                            Icons.card_giftcard,
                            color: preto,
                          ),
                          expandedAlignment: Alignment.centerLeft,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          childrenPadding:
                              const EdgeInsets.fromLTRB(18.0, 0.0, 5.0, 5.0),
                          title: Text(
                            'Dados do teu pedido',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: preto,
                            ),
                          ),
                          initiallyExpanded: true,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text('Arroz peixe feijao na Cost de',
                                textAlign: TextAlign.right),
                            const SizedBox(height: 5.0),
                            Container(
                              color: branco,
                              height: 100.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText:
                                      'Onde comprar?(toque aqui para escrever)',
                                  hintText:
                                      'Digite a localização, referencia do local\nonde podemos comprar!  ',
                                  hintStyle: const TextStyle(fontSize: 12.0),
                                  border: const OutlineInputBorder(),
                                  focusColor: azul,
                                ),
                                style: const TextStyle(
                                    decoration: TextDecoration.none),
                                maxLines: null,
                                maxLength: 255,
                                //expands: true,
                                cursorHeight: 20.0,
                                cursorColor: azul,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Custo estimado do produto',
                                style: TextStyle(
                                  color: preto,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Wrap(spacing: 8, runSpacing: 8, children: [
                              PriceSelector(),
                              PriceSelector(),
                            ]),
                          ],
                        ),
                      ),
                      //Detalhes da Entrega
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: branco,
                        //height: 200.0,
                        margin: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        child: ExpansionTile(
                          leading: Icon(
                            Icons.delivery_dining,
                            color: preto,
                          ),
                          expandedAlignment: Alignment.centerLeft,
                          childrenPadding:
                              const EdgeInsets.fromLTRB(18.0, 0.0, 5.0, 5.0),
                          title: Text(
                            'Detalhes da Entrega',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: preto,
                            ),
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Container(
                              color: branco,
                              //height: 200.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText:
                                      'Onde Entregar?(toque aqui para escrever)',
                                  hintText:
                                      'Digite a localização, referencia do local\nonde podemos entregar!  ',
                                  hintStyle: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                  border: const OutlineInputBorder(),
                                  focusColor: azul,
                                ),
                                style: const TextStyle(
                                    decoration: TextDecoration.none),
                                maxLines: null,
                                maxLength: 255,
                                //expands: true,
                                cursorHeight: 20.0,
                                cursorColor: azul,
                              ),
                            ),
                            DateTimePicker(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      //Metodo de pagamento
                      Container(
                        color: branco,
                        //height: 200.0,
                        margin: const EdgeInsets.all(0),
                        alignment: Alignment.centerLeft,
                        child: ExpansionTile(
                          leading: Icon(
                            Icons.credit_card_outlined,
                            color: preto,
                          ),
                          expandedAlignment: Alignment.centerLeft,
                          childrenPadding:
                              const EdgeInsets.fromLTRB(18.0, 0.0, 5.0, 5.0),
                          title: Text(
                            'Método de Pagamento',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: preto,
                            ),
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Selecione um método:',
                                        style: TextStyle(
                                          color: preto,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            DropDownPay(payMethod),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
