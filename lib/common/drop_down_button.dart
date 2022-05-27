import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';

class DropDownPay extends StatefulWidget {
  String payMethod;
  DropDownPay( this.payMethod);

  @override
  // ignore: no_logic_in_create_state
  _DropDownPayState createState() => _DropDownPayState(this.payMethod);
}

class _DropDownPayState extends State<DropDownPay> {
   String chosenValue ;
   _DropDownPayState(this.chosenValue);
  List<String> payMethodList = ['Dinheiro', 'TPA', 'Referencia'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: chosenValue,
      isExpanded: true,
      style: TextStyle(color: preto),
      hint: const Text(
        'Selecione',
        style: TextStyle(fontSize: 14),
      ),
      onChanged: (String value) {
        setState(() {
          chosenValue = value;
        });
      },
      items: payMethodList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }
}
