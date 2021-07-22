import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseAtividade extends StatefulWidget {
  Atividade atividade;
  String _caracteristica;
  ClasseAtividade(this.atividade, this._caracteristica);

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
    _descricaoTexto = new TextEditingController(text: widget.atividade.getDescricao());
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
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                enabled: _atividadeTexto.text.isEmpty || widget.atividade.getId() == -1,
                focusNode: _focusNodeAtividade,
                controller: _atividadeTexto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cadastrar Atividade*',
                  hintText: 'Digite uma atividade*',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextField(
                controller: _descricaoTexto,
                focusNode: _focusNodeDescricao,
                autofocus: false,
                maxLength: 150,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Detalhe a atividade para o clubista*',
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 250,
                    ),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cancelar atividade",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 250,
                    ),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar atividade",
                        style: TextStyle(fontSize: 20),
                      ),
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
                          Navigator.pop(context, _atividade);
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
