import 'package:flutter/material.dart';

class ClasseCadastrarNovaPergunta extends StatefulWidget {
  @override
  CadastrarNovaPergunta createState() => CadastrarNovaPergunta();
}

class CadastrarNovaPergunta extends State<ClasseCadastrarNovaPergunta> {
  TextEditingController _perguntaTexto;
  TextEditingController _respostaTexto;
  FocusNode _focusNodePergunta;
  FocusNode _focusNodeResposta;

  @override
  void initState() {
    super.initState();
    _perguntaTexto = new TextEditingController();
    _respostaTexto = new TextEditingController();
    _focusNodePergunta = FocusNode();
    _focusNodeResposta = FocusNode();
  }

  @override
  void dispose() {
    _focusNodePergunta.dispose();
    _focusNodeResposta.dispose();
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
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: TextField(
                focusNode: _focusNodePergunta,
                controller: _perguntaTexto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite a sua pergunta*',
                  hintText: 'Escreva uma pergunta nova*',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField(
                focusNode: _focusNodeResposta,
                controller: _respostaTexto,
                autofocus: false,
                maxLength: 150,
                maxLines: 8,
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
            Padding(
              padding: EdgeInsets.zero,
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
                        chamaTelaVisualizarRoteiroNaoDefinido(context, _perguntaTexto.text);
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
                        if (_perguntaTexto.text.isEmpty)
                          _focusNodePergunta.requestFocus();
                        else if (_respostaTexto.text.isEmpty)
                          _focusNodeResposta.requestFocus();
                        else {
                          chamaTelaVisualizarRoteiroNaoDefinido(context, _perguntaTexto.text);
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

  chamaTelaVisualizarRoteiroNaoDefinido(BuildContext context, String sPergunta) {
    Navigator.pop(context);
  }
}
