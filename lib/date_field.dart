import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_widgets/date_picker.dart';

class DateField extends StatelessWidget {
  DateField(
      {super.key,
      required this.labelText,
      required this.onChanged,
      required this.data});

  int anoInicial = 2014;
  int anoFinal = 2024;

  ({String ano, String mes, String dia}) data;

  String labelText;

  Function onChanged;

  var txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (data.ano.isNotEmpty) {
      print('anov${data}');
      _updateTexto(
          int.parse(data.ano) - anoInicial + 1,
          data.mes.isEmpty ? 0 : int.parse(data.mes),
          data.dia.isEmpty ? 0 : int.parse(data.dia));
    }

    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      readOnly: true,
      controller: txt,
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          builder: (BuildContext context) {
            return SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 70,
                        ),
                      ),
                      const Text(
                        "Selecionar Data",
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF525252),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 80,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Aplicar"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: CustomDatePicker(
                      anoInicial: anoInicial,
                      anoFinal: anoFinal,
                      data: data,
                      onChanged: (ano, mes, dia) {
                        _updateTexto(ano, mes, dia);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _updateTexto(ano, mes, dia) {
    txt.text = '';

    print('_updateTexto: ${ano}');

    if (ano != 0) {
      txt.text = '${ano + anoInicial - 1}';
    }

    if (mes != 0) {
      txt.text = '${mes.toString().padLeft(2, '0')}/${txt.text}';
    }

    if (dia != 0) {
      txt.text = '${dia.toString().padLeft(2, '0')}/${txt.text}';
    }

    var spl = txt.text.split("/");
    onChanged(spl.isNotEmpty ? spl[0] : '', spl.length >= 2 ? spl[1] : '',
        spl.length >= 3 ? spl[2] : '');
  }
}
