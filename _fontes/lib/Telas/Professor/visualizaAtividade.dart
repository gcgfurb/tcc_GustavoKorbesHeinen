import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseVisualizaAtividade extends StatefulWidget {
  Atividade _atividade = new Atividade('', '');
  ClasseVisualizaAtividade(this._atividade);

  @override
  VisualizaAtividade createState() => VisualizaAtividade();
}

class VisualizaAtividade extends State<ClasseVisualizaAtividade> {
  TextEditingController _atividadeTexto;
  TextEditingController _descricaoTexto;

  @override
  void initState() {
    super.initState();
    _atividadeTexto = new TextEditingController(text: widget._atividade.getAtividade());
    _descricaoTexto = new TextEditingController(text: widget._atividade.getDescricao());
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
                controller: _atividadeTexto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cadastrar Atividade',
                  hintText: 'Digite uma atividade',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                autofocus: false,
                maxLength: 150,
                maxLines: 7,
                controller: _descricaoTexto,
                decoration: InputDecoration(
                  hintText: 'Objetivo geral da atividade de campo*',
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
                        chamaTelaRoteiro(context);
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
                        widget._atividade.setAtividade(_atividadeTexto.text);
                        widget._atividade.setDescricao(_descricaoTexto.text);
                        chamaTelaRoteiro(context);
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

  void chamaTelaRoteiro(BuildContext context) {
    Navigator.pop(context);
  }
}
