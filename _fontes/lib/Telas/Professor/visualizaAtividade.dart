import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseVisualizaAtividade extends StatefulWidget {
  Atividade atividade;
  ClasseVisualizaAtividade(this.atividade);

  @override
  VisualizaAtividade createState() => VisualizaAtividade();
}

class VisualizaAtividade extends State<ClasseVisualizaAtividade> {
  TextEditingController _tecAtividade;
  TextEditingController _tecDescricao;

  @override
  void initState() {
    super.initState();
    _tecAtividade = new TextEditingController(text: widget.atividade.getNomeAtividade());
    _tecDescricao = new TextEditingController(text: widget.atividade.getDescricao());
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
            Expanded(
              child: TextField(
                enabled: widget.atividade.getId() < 0,
                controller: _tecAtividade,
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
                controller: _tecDescricao,
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
                        Navigator.pop(context);
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
                        widget.atividade.setNomeAtividade(_tecAtividade.text);
                        widget.atividade.setDescricao(_tecDescricao.text);
                        Navigator.pop(context);
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
