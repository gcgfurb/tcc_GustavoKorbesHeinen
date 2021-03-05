import 'package:flutter/material.dart';
import 'package:teste/Classes/Atividade.dart';
import 'package:teste/Classes/ObjEspecifico.dart';

class ClasseAtividade extends StatefulWidget {
  ObjEspecifico _objEspecifico = new ObjEspecifico();
  ClasseAtividade(this._objEspecifico);

  @override
  CadastraNovaAtividade createState() => CadastraNovaAtividade();
}

class CadastraNovaAtividade extends State<ClasseAtividade> {
  TextEditingController _atividadeTexto = new TextEditingController();
  TextEditingController _descricaoTexto = new TextEditingController();

  FocusNode _focusNodeAtividade;

  @override
  void initState() {
    super.initState();
    _focusNodeAtividade = FocusNode();
  }

  @override
  void dispose() {
    _focusNodeAtividade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                focusNode: _focusNodeAtividade,
                controller: _atividadeTexto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cadastrar Atividade*',
                  hintText: 'Digite uma atividade*',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                controller: _descricaoTexto,
                autofocus: false,
                maxLength: 150,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Objetivo geral da atividade de campo',
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 250,
                    ),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Cancelar atividade"),
                      onPressed: () {
                        chamaTelaRoteiro(context, widget._objEspecifico);
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 250,
                    ),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Cadastrar atividade"),
                      onPressed: () {
                        if (_atividadeTexto.text.isEmpty)
                          _focusNodeAtividade.requestFocus();
                        else {
                          Atividade _atividade = new Atividade(_atividadeTexto.text, _descricaoTexto.text);
                          widget._objEspecifico.getRoteiro().adicionaAtividade(_atividade);
                          chamaTelaRoteiro(context, widget._objEspecifico);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void chamaTelaRoteiro(BuildContext context, ObjEspecifico objEspecifico) {
  Navigator.pop(context, objEspecifico);
}
