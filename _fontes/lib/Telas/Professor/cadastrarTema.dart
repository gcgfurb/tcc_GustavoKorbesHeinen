import 'package:flutter/material.dart';
import 'package:teste/Classes/Tema.dart';
import 'cadastrarObjEspecificos.dart';

class ClasseTema extends StatefulWidget {
  Tema temaAtual = new Tema();
  ClasseTema(this.temaAtual);

  @override
  CadastrarTema createState() => CadastrarTema();
}

class CadastrarTema extends State<ClasseTema> {
  TextEditingController temaTexto;
  TextEditingController descricaoTexto;
  FocusNode focusNodeTema;
  FocusNode focusNodeDescricao;

  @override
  void initState() {
    super.initState();
    temaTexto = new TextEditingController(text: widget.temaAtual.getTema());
    descricaoTexto = new TextEditingController(text: widget.temaAtual.getDescricao());
    focusNodeTema = FocusNode();
    focusNodeDescricao = FocusNode();
  }

  @override
  void dispose() {
    focusNodeTema.dispose();
    focusNodeDescricao.dispose();
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
              padding: EdgeInsets.all(15),
              child: TextField(
                focusNode: focusNodeTema,
                controller: temaTexto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cadastrar Tema*',
                  hintText: 'Digite um Tema*',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: TextField(
                focusNode: focusNodeDescricao,
                controller: descricaoTexto,
                maxLength: 150,
                maxLines: 7,
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
              child: IntrinsicWidth(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      width: 300,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        color: Colors.green[500],
                        textColor: Colors.white,
                        child: Text(
                          "Cadastrar Objetivos Específicos para o Tema (opcional)",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          if (temaTexto.text.isEmpty)
                            focusNodeTema.requestFocus();
                          else if (descricaoTexto.text.isEmpty)
                            focusNodeDescricao.requestFocus();
                          else
                            chamaTelaCadastrarObjetivosEspecificos(context, widget.temaAtual);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      width: 300,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        textColor: Colors.white,
                        color: Colors.green[500],
                        child: Text(
                          "Finalizar Tema e gerar QRCode",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          if (temaTexto.text.isEmpty)
                            focusNodeTema.requestFocus();
                          else if (descricaoTexto.text.isEmpty)
                            focusNodeDescricao.requestFocus();
                          else
                            finalizarTemaGerarQRCode();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void chamaTelaCadastrarObjetivosEspecificos(BuildContext context, Tema temaAtual) async {
    widget.temaAtual = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseObjEspecifico(temaAtual)));
    setState(() {});
  }

  void finalizarTemaGerarQRCode() {
    widget.temaAtual.setTema(temaTexto.text);
    widget.temaAtual.setDescricao(descricaoTexto.text);

    Navigator.pop(context, widget.temaAtual);
  }
}
