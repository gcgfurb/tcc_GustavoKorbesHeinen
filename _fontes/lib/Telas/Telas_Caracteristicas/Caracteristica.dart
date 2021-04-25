import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaCaracteristica.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseCaracteristica extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseCaracteristica(this._atividade);

  @override
  Caracteristica createState() => Caracteristica();
}

class Caracteristica extends State<ClasseCaracteristica> {
  TextEditingController _tecResposta = new TextEditingController();
  FocusNode _fnResposta;

  @override
  void initState() {
    super.initState();

    dynamic caracteristica = widget._atividade.respostaAtividade;

    if (caracteristica != null) {
      _tecResposta.text = caracteristica.getResposta();
    }

    _fnResposta = FocusNode();
  }

  @override
  void dispose() {
    _fnResposta.dispose();
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
            Padding(
              padding: EdgeInsets.all(15),
              child: Text('Registe as característica que foram observadas:'),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Text(widget._atividade.getDescricao()),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: TextField(
                controller: _tecResposta,
                focusNode: _fnResposta,
                maxLength: 150,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Objetivo geral da atividade de campo*',
                  hintText: 'Procurar árvore araucária',
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    width: 200,
                    height: 100,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text(
                        "Gravar",
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        if (validaCampos()) {
                          widget._atividade.adicionaResposta(CaracteristicaCaracteristica(_tecResposta.text));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    width: 200,
                    height: 100,
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        textColor: Colors.white,
                        color: Colors.red,
                        child: Text(
                          "Cancelar",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validaCampos() {
    if (_tecResposta.text.isEmpty) {
      _fnResposta.requestFocus();
      return false;
    }

    return true;
  }
}
