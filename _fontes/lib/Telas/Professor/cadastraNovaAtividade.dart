import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/Roteiro.dart';

class ClasseAtividade extends StatefulWidget {
  Roteiro roteiro;
  String _caracteristica;
  ClasseAtividade(this.roteiro, this._caracteristica);

  @override
  CadastraNovaAtividade createState() => CadastraNovaAtividade();
}

class CadastraNovaAtividade extends State<ClasseAtividade> {
  TextEditingController _atividadeTexto;
  TextEditingController _descricaoTexto = new TextEditingController();

  FocusNode _focusNodeAtividade;
  FocusNode _focusNodeDescricao;

  void initState() {
    super.initState();
    _atividadeTexto = new TextEditingController(text: widget._caracteristica);
    _focusNodeAtividade = FocusNode();
    _focusNodeDescricao = FocusNode();
  }

  @override
  void dispose() {
    _focusNodeAtividade.dispose();
    _focusNodeDescricao.dispose();
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
                enabled: _atividadeTexto.text.isEmpty,
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
                focusNode: _focusNodeDescricao,
                autofocus: false,
                maxLength: 150,
                maxLines: 10,
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
                        if (_atividadeTexto.text.isEmpty)
                          _focusNodeAtividade.requestFocus();
                        else if (_descricaoTexto.text.isEmpty)
                          _focusNodeDescricao.requestFocus();
                        else {
                          Atividade _atividade = new Atividade();
                          _atividade.setId(Util.stringToId(_atividadeTexto.text));
                          _atividade.setNomeAtividade(_atividadeTexto.text);
                          _atividade.setDescricao(_descricaoTexto.text);
                          widget.roteiro.adicionaAtividade(_atividade);
                          chamaTelaRoteiro(context);
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

void chamaTelaRoteiro(BuildContext context) {
  Navigator.pop(context);
}
