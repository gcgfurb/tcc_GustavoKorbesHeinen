import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaInteracao.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseInteracao extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseInteracao(this._atividade);

  @override
  Interacao createState() => Interacao();
}

class Interacao extends State<ClasseInteracao> {
  TextEditingController _tecResposta1 = new TextEditingController();
  TextEditingController _tecResposta2 = new TextEditingController();

  FocusNode _fnResposta1;
  FocusNode _fnResposta2;

  void initState() {
    super.initState();
    dynamic interacao = widget._atividade.respostaAtividade;

    if (interacao != null) {
      _tecResposta1.text = interacao.getResposta1();
      _tecResposta2.text = interacao.getResposta2();
    }

    _fnResposta1 = FocusNode();
    _fnResposta2 = FocusNode();
  }

  @override
  void dispose() {
    _fnResposta1.dispose();
    _fnResposta2.dispose();
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
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text("Registro de interações entre espécies:"),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
              child: Text(widget._atividade.getDescricao()),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: TextField(
                  focusNode: _fnResposta1,
                  controller: _tecResposta1,
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Seres vivos que interagiram?*', hintText: 'Interação entre planta X e animal Y'),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                  focusNode: _fnResposta2,
                  controller: _tecResposta2,
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual interação ocorreu?*', hintText: 'Girafa se alimentando da árvore'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Gravar"),
                      onPressed: () {
                        widget._atividade.adicionaResposta(CaracteristicaInteracao(_tecResposta1.text, _tecResposta2.text));
                        Navigator.pop(context);
                      }),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Cancelar"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
