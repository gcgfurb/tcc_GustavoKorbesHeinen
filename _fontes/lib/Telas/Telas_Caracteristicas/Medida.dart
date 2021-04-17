import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaMedida.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseMedida extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseMedida(this._atividade);

  @override
  Medida createState() => Medida();
}

class Medida extends State<ClasseMedida> {
  String dropdownValue = "peso";
  String dropdownValue2 = "borracha";
  String dropdownValue3 = "peso";
  String dropdownValue4 = "borracha";
  bool _campoAdicional = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text("Medidas observadas:  "),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
              child: Text(widget._atividade.getDescricao()),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 5, 20),
                  child: DropdownButton<String>(
                    focusColor: Colors.green,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_circle),
                    iconSize: 24,
                    style: const TextStyle(color: Colors.purpleAccent),
                    iconEnabledColor: Colors.blueGrey,
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>["peso", "circunferência", "altura", "largura", "espessura", "raio"].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                  child: DropdownButton<String>(
                    focusColor: Colors.green,
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_drop_down_circle),
                    iconSize: 24,
                    style: const TextStyle(color: Colors.purpleAccent),
                    iconEnabledColor: Colors.blueGrey,
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue2 = newValue;
                      });
                    },
                    items: <String>["um", "borracha", "tres", "quatro"].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 20, 20),
                    child: TextField(
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual o valor obtido?*', hintText: '5'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 20, 20),
                  child: TextButton.icon(
                    label: Text(''),
                    style: TextButton.styleFrom(
                      primary: Colors.black54,
                    ),
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      setState(() {
                        _campoAdicional = true;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_campoAdicional)
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 5, 20),
                    child: DropdownButton<String>(
                      focusColor: Colors.green,
                      value: dropdownValue3,
                      icon: const Icon(Icons.arrow_drop_down_circle),
                      iconSize: 24,
                      style: const TextStyle(color: Colors.purpleAccent),
                      iconEnabledColor: Colors.blueGrey,
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue3 = newValue;
                        });
                      },
                      items: <String>["peso", "circunferência", "altura", "largura", "espessura", "raio"].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                    child: DropdownButton<String>(
                      focusColor: Colors.green,
                      value: dropdownValue4,
                      icon: const Icon(Icons.arrow_drop_down_circle),
                      iconSize: 24,
                      style: const TextStyle(color: Colors.purpleAccent),
                      iconEnabledColor: Colors.blueGrey,
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue4 = newValue;
                        });
                      },
                      items: <String>["um", "borracha", "tres", "quatro"].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 20, 20, 20),
                      child: TextField(
                        decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual o valor obtido?*', hintText: '5'),
                      ),
                    ),
                  ),
                ],
              ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Essas medidas resultaram em algum cálculo?*', hintText: 'Sim, área, volume, fórmula...'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                  child: ElevatedButton(
                    child: Text('Gravar'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      print('Pressed');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 20, 20),
                  child: ElevatedButton(
                    child: Text('Cancelar'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
