import 'package:flutter/material.dart';
import 'package:TCC_II/Telas/Aluno/verTema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';

import 'cadastrarNovaPergunta.dart';

class ClasseRoteiroNaoDefinido extends StatefulWidget {
  ObjEspecifico _objEspecifico = new ObjEspecifico();
  ClasseRoteiroNaoDefinido(this._objEspecifico);

  @override
  VisualizarRoteiroNaoDefinido createState() => VisualizarRoteiroNaoDefinido();
}

class VisualizarRoteiroNaoDefinido extends State<ClasseRoteiroNaoDefinido> {
  List<String> listaRoteiroPergunta = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 6,
                    child: Text(
                      'Objetivo: ' + widget._objEspecifico.getObjetivo(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 30),
                    )),
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text("Ajuda"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: <Widget>[
                  if (widget._objEspecifico.getRoteiro().getQtdAtividades() > 0)
                    Expanded(
                      flex: 2,
                      child: GridView.count(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 4,
                        scrollDirection: Axis.vertical,
                        primary: false,
                        children: List.generate(widget._objEspecifico.getRoteiro().getQtdAtividades(), (index) {
                          return RaisedButton(
                            color: Colors.green[500],
                            textColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget._objEspecifico.getRoteiro().getAtividade(index).getNomeAtividade(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onPressed: () {
                              inserirPerguntaNaCaixa(context, widget._objEspecifico.getRoteiro().getAtividade(index).getDescricao());
                            },
                          );
                        }),
                      ),
                    ),
                  Expanded(
                    child: ListView(
                      children: getListItems(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar nova pergunta",
                        textAlign: TextAlign.justify,
                      ),
                      onPressed: () {
                        chamaTelaCadastrarNovaPergunta(context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Voltar"),
                      onPressed: () {
                        chamaTelaObjEspecificos(context);
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

  List<ListTile> getListItems() => listaRoteiroPergunta.asMap().map((index, item) => MapEntry(index, geraLista(item, index))).values.toList();

  ListTile geraLista(String item, int index) => ListTile(
        key: ValueKey(item),
        title: Text(item),
        leading: Text("#${index + 1}"),
        dense: true,
      );

  void inserirPerguntaNaCaixa(BuildContext context, String sPergunta) {
    setState(() {
      listaRoteiroPergunta.add(sPergunta);
    });
  }

  void chamaTelaCadastrarNovaPergunta(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCadastrarNovaPergunta()));
  }

  void chamaTelaObjEspecificos(BuildContext context) {
    Navigator.pop(context);
  }
}
