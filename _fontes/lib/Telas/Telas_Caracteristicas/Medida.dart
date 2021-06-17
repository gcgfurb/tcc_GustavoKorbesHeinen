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
  int ddVDimensao1;
  int ddVDimensao2;
  int ddVUnMed1;
  int ddVUnMed2;
  bool _campoAdicional = false;

  List<String> dimensoes = <String>["peso", "circunferência", "altura", "largura", "espessura", "raio"];
  List<String> unMedPeso = <String>["mg", "g", "kg", "ton"];
  List<String> unMedTam = <String>["mm", "cm", "m", "km"];
  List<String> unMedAtual1 = [];
  List<String> unMedAtual2 = [];

  TextEditingController _tecValor1 = new TextEditingController();
  TextEditingController _tecValor2 = new TextEditingController();
  TextEditingController _tecCalculo = new TextEditingController();

  FocusNode _fnValor1;
  FocusNode _fnValor2;

  void initState() {
    super.initState();
    dynamic medida = widget._atividade.getRespostaAtividade();

    if (medida != null) {
      ddVDimensao1 = medida.getDimensao1();
      ddVDimensao2 = medida.getDimensao2();
      ddVUnMed1 = medida.getUnMed1();
      ddVUnMed2 = medida.getUnMed2();
      _tecValor1.text = medida.getValor1().toString();
      _tecValor2.text = medida.getValor2().toString();
      _tecCalculo.text = medida.getCalculo();

      ddVDimensao1 == 0 ? unMedAtual1 = unMedPeso : unMedAtual1 = unMedTam;
      ddVDimensao2 == 0 ? unMedAtual2 = unMedPeso : unMedAtual2 = unMedTam;
      if (ddVDimensao2 != null) _campoAdicional = true;
    }

    _fnValor1 = FocusNode();
    _fnValor2 = FocusNode();
  }

  @override
  void dispose() {
    _fnValor1.dispose();
    _fnValor2.dispose();

    super.dispose();
  }

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
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                "Medidas observadas: ",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15),
              child: Text(
                widget._atividade.getDescricao(),
                style: TextStyle(fontSize: 30),
              ),
            ),
            criaCampos(false),
            if (_campoAdicional) criaCampos(true),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: TextField(
                controller: _tecCalculo,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Essas medidas resultaram em algum cálculo?', hintText: 'Sim, área, volume, fórmula...'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Gravar',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      if (validaCampos()) {
                        widget._atividade.adicionaResposta(
                            CaracteristicaMedida(ddVDimensao1, ddVUnMed1, int.parse(_tecValor1.text), ddVDimensao2, ddVUnMed2, _campoAdicional ? int.parse(_tecValor2.text) : 0, _tecCalculo.text));
                        Navigator.pop(context);
                      }
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

  bool validaCampos() {
    FocusManager.instance.primaryFocus.unfocus();
    if (ddVDimensao1 == null || ddVUnMed1 == null) return false;
    if (_campoAdicional) if (ddVDimensao2 == null || ddVUnMed2 == null) return false;

    if (_tecValor1.text.isEmpty) {
      _fnValor1.requestFocus();
      return false;
    }
    if (_campoAdicional && _tecValor2.text.isEmpty) {
      _fnValor2.requestFocus();
      return false;
    }

    return true;
  }

  Widget criaCampos(bool bRepetido) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 4.5, 10, 4.5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.green,
            hint: Text("Dimensão*"),
            value: bRepetido
                ? ddVDimensao2 == null
                    ? null
                    : dimensoes[ddVDimensao2]
                : ddVDimensao1 == null
                    ? null
                    : dimensoes[ddVDimensao1],
            icon: const Icon(Icons.arrow_drop_down_circle),
            iconSize: 24,
            iconEnabledColor: Colors.black54,
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String newValue) {
              FocusManager.instance.primaryFocus.unfocus();
              if (bRepetido) {
                ddVDimensao2 = dimensoes.indexOf(newValue);
                if (ddVDimensao2 == 0)
                  unMedAtual2 = unMedPeso;
                else
                  unMedAtual2 = unMedTam;
              } else {
                ddVDimensao1 = dimensoes.indexOf(newValue);
                if (ddVDimensao1 == 0)
                  unMedAtual1 = unMedPeso;
                else
                  unMedAtual1 = unMedTam;
              }
              setState(() {});
            },
            items: dimensoes.map((String value) {
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
          padding: EdgeInsets.only(left: 5),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 4.5, 10, 4.5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.green,
            hint: Text("Un. Medida*"),
            value: bRepetido
                ? ddVUnMed2 == null
                    ? null
                    : unMedAtual2[ddVUnMed2]
                : ddVUnMed1 == null
                    ? null
                    : unMedAtual1[ddVUnMed1],
            icon: const Icon(Icons.arrow_drop_down_circle),
            iconSize: 24,
            iconEnabledColor: Colors.black54,
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String newValue) {
              FocusManager.instance.primaryFocus.unfocus();
              setState(() {
                if (bRepetido)
                  ddVUnMed2 = unMedAtual2.indexOf(newValue);
                else
                  ddVUnMed1 = unMedAtual1.indexOf(newValue);
              });
            },
            items: (bRepetido ? unMedAtual2 : unMedAtual1).map((String value) {
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
            padding: EdgeInsets.fromLTRB(5, 10, bRepetido ? 64 : 0, 10),
            child: TextField(
              controller: bRepetido ? _tecValor2 : _tecValor1,
              focusNode: bRepetido ? _fnValor2 : _fnValor1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual o valor obtido?*', hintText: '5'),
            ),
          ),
        ),
        if (!bRepetido)
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: TextButton.icon(
              label: Text(''),
              style: TextButton.styleFrom(
                primary: Colors.black54,
              ),
              icon: Icon(Icons.add_circle),
              onPressed: () {
                FocusManager.instance.primaryFocus.unfocus();
                setState(() {
                  _campoAdicional = true;
                });
              },
            ),
          ),
      ],
    );
  }
}
