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
    dynamic interacao = widget._atividade.getRespostaAtividade();

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
              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              child: Text(
                "Registro de interações entre espécies:",
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
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
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
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: TextField(
                  focusNode: _fnResposta2,
                  controller: _tecResposta2,
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual interação ocorreu?*', hintText: 'Girafa se alimentando da árvore'),
                ),
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
                        widget._atividade.adicionaResposta(CaracteristicaInteracao(_tecResposta1.text, _tecResposta2.text));
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
    if (_tecResposta1.text.isEmpty) {
      _fnResposta1.requestFocus();
      return false;
    }

    if (_tecResposta2.text.isEmpty) {
      _fnResposta2.requestFocus();
      return false;
    }

    return true;
  }
}
