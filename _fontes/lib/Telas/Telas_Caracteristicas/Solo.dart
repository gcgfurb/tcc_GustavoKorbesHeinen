import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaSolo.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseSolo extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseSolo(this._atividade);

  @override
  Solo createState() => Solo();
}

class Solo extends State<ClasseSolo> {
  TextEditingController _tecResposta1 = new TextEditingController();
  TextEditingController _tecResposta2 = new TextEditingController();
  TextEditingController _tecResposta3 = new TextEditingController();
  TextEditingController _tecResposta4 = new TextEditingController();

  FocusNode _fnResposta1;
  FocusNode _fnResposta2;
  FocusNode _fnResposta3;
  FocusNode _fnResposta4;

  void initState() {
    super.initState();
    dynamic solo = widget._atividade.getRespostaAtividade();

    if (solo != null) {
      _tecResposta1.text = solo.getResposta1();
      _tecResposta2.text = solo.getResposta2();
      _tecResposta3.text = solo.getResposta3();
      _tecResposta4.text = solo.getResposta4();
    }

    _fnResposta1 = FocusNode();
    _fnResposta2 = FocusNode();
    _fnResposta3 = FocusNode();
    _fnResposta4 = FocusNode();
  }

  @override
  void dispose() {
    _fnResposta1.dispose();
    _fnResposta2.dispose();
    _fnResposta3.dispose();
    _fnResposta4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              child: Text(
                "Observe o solo:",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              child: Text(
                widget._atividade.getDescricao(),
                style: TextStyle(fontSize: 30),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 15),
                    child: TextField(
                      focusNode: _fnResposta1,
                      controller: _tecResposta1,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual a coloração do solo?*', hintText: 'Marrom amarelado, verde, preto'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 15, 15),
                    child: TextField(
                      focusNode: _fnResposta2,
                      controller: _tecResposta2,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Há matéria orgânica? Quais?*', hintText: 'Sim, argila, minhoca'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 15),
                    child: TextField(
                      focusNode: _fnResposta3,
                      controller: _tecResposta3,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual a granulometria?*', hintText: 'Argila, areia, cascalho...'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 15, 15),
                    child: TextField(
                      focusNode: _fnResposta4,
                      controller: _tecResposta4,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Elementos químicos presentes no solo*', hintText: 'Carbono, oxigênio, fósforo...'),
                    ),
                  ),
                ),
              ],
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
                          widget._atividade.adicionaResposta(CaracteristicaSolo(_tecResposta1.text, _tecResposta2.text, _tecResposta3.text, _tecResposta4.text));
                          return Navigator.pop(context, widget._atividade);
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validaCampos() {
    if (_tecResposta1.text.isEmpty) {
      _fnResposta1.requestFocus();
      return false;
    }

    if (_tecResposta2.text.isEmpty) {
      _fnResposta2.requestFocus();
      return false;
    }

    if (_tecResposta3.text.isEmpty) {
      _fnResposta3.requestFocus();
      return false;
    }

    if (_tecResposta4.text.isEmpty) {
      _fnResposta4.requestFocus();
      return false;
    }

    return true;
  }
}
