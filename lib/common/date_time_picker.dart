import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:operativo_final_cliente/common/colors.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              // ignore: unnecessary_string_interpolations
              Text("Data: ${DateFormat.yMEd() .format(selectedDate.toLocal()) }",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Seleciona Dia'),
              ),
            ],
          ),
        )
      ],
    );

  }


 _selectDate(BuildContext context) async{
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch(theme.platform){
      case TargetPlatform.android:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        //return buildMaterialDatePicker(context);
        return buildCupertinoDateTimePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDateTimePicker(context);
    }
  }


  buildMaterialDatePicker(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2021),
        builder: (context,child){
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
      }
    );
    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }

  }

  buildCupertinoDateTimePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder){
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: branco,
            child: CupertinoDatePicker(
              mode:  CupertinoDatePickerMode.time,
              onDateTimeChanged: (picked){
                if(picked != null && picked != selectedDate){
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              initialDateTime: selectedDate,
              minimumYear: 2021,
              maximumYear: 2021,
            ),
          );
        }
    );
  }
}



