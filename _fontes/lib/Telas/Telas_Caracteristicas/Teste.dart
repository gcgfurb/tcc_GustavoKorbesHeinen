import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaTeste.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseTeste extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseTeste(this._atividade);

  @override
  Teste createState() => Teste();
}

class Teste extends State<ClasseTeste> {
  int ddVOpcoes;

  List<String> opcoes = <String>["pH", "Oxigênio", "Cloro", "Qualidade da Água", "Temperatura", "Umidade"];

  TextEditingController _tecValor = new TextEditingController();

  FocusNode _fnValor;

  void initState() {
    super.initState();
    dynamic teste = widget._atividade.getRespostaAtividade();

    if (teste != null) {
      ddVOpcoes = teste.getResposta1();
      _tecValor.text = teste.getResposta2().toString();
    }

    _fnValor = FocusNode();
  }

  @override
  void dispose() {
    _fnValor.dispose();

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
              padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
              child: Text(
                "Registro dos testes realizados: ",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
              child: Text(
                widget._atividade.getDescricao(),
                style: TextStyle(fontSize: 30),
              ),
            ),
            criaCampos(),
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
                        widget._atividade.adicionaResposta(CaracteristicaTeste(ddVOpcoes, int.parse(_tecValor.text)));
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
    if (ddVOpcoes == null) return false;

    if (_tecValor.text.isEmpty) {
      _fnValor.requestFocus();
      return false;
    }

    return true;
  }

  Widget criaCampos() {
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
            hint: Text("Teste realizado"),
            value: ddVOpcoes == null ? null : opcoes[ddVOpcoes],
            icon: const Icon(Icons.arrow_drop_down_circle),
            iconSize: 24,
            iconEnabledColor: Colors.black54,
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String newValue) {
              FocusManager.instance.primaryFocus.unfocus();
              ddVOpcoes = opcoes.indexOf(newValue);
              setState(() {});
            },
            items: opcoes.map((String value) {
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
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 15, 20),
            child: TextField(
              controller: _tecValor,
              focusNode: _fnValor,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual o valor obtido?*', hintText: '5'),
            ),
          ),
        ),
      ],
    );
  }
}
