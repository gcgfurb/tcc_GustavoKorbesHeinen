import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaPersonalizada.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseNovaPergunta extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseNovaPergunta(this._atividade);

  @override
  CadastrarNovaPergunta createState() => CadastrarNovaPergunta();
}

class CadastrarNovaPergunta extends State<ClasseNovaPergunta> {
  TextEditingController _tecPergunta = new TextEditingController();
  TextEditingController _tecResposta = new TextEditingController();
  FocusNode _fnPergunta;
  FocusNode _fnResposta;

  void initState() {
    super.initState();
    dynamic pergunta = widget._atividade.respostaAtividade;

    if (pergunta != null) {
      _tecPergunta.text = pergunta.getPergunta();
      _tecResposta.text = pergunta.getResposta();
    }

    _fnPergunta = FocusNode();
    _fnResposta = FocusNode();
  }

  @override
  void dispose() {
    _fnPergunta.dispose();
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
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: TextField(
                focusNode: _fnPergunta,
                controller: _tecPergunta,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite a sua pergunta*',
                  hintText: 'Qual é a cor da terra?',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField(
                focusNode: _fnResposta,
                controller: _tecResposta,
                autofocus: false,
                maxLength: 150,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Resposta da sua pergunta*',
                  hintText: 'Azul, Preta, Marrom',
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
                      child: Text("Cadastrar atividade"),
                      onPressed: () {
                        if (_tecPergunta.text.isEmpty)
                          _fnPergunta.requestFocus();
                        else if (_tecResposta.text.isEmpty)
                          _fnResposta.requestFocus();
                        else {
                          widget._atividade.adicionaResposta(CaracteristicaPersonalizada(_tecPergunta.text, _tecResposta.text));
                          Navigator.pop(context, widget._atividade);
                        }
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
                      child: Text("Cancelar atividade"),
                      onPressed: () {
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
