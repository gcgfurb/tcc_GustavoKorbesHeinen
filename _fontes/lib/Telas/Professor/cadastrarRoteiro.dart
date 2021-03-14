import 'package:flutter/material.dart';
import 'package:teste/Classes/ObjEspecifico.dart';
import 'package:teste/Classes/Atividade.dart';
import 'package:teste/Telas/Professor/visualizaAtividade.dart';
import 'cadastraNovaAtividade.dart';

class ClasseRoteiro extends StatefulWidget {
  ObjEspecifico _objEspecifico = new ObjEspecifico();
  ClasseRoteiro(this._objEspecifico);

  @override
  CadastrarRoteiro createState() => CadastrarRoteiro();
}

class CadastrarRoteiro extends State<ClasseRoteiro> {
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
                                  widget._objEspecifico.getRoteiro().getAtividade(index).getAtividade(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            onPressed: () {
                              chamaTelaVisualizarAtividade(context, widget._objEspecifico.getRoteiro().getAtividade(index));
                            },
                          );
                        }),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ReorderableListView(
                            onReorder: onReorder,
                            children: getListItems(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: CheckboxListTile(
                      title: Text("Este roteiro deve ser realizado na ordem proposta"),
                      secondary: Icon(Icons.account_box_outlined),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: widget._objEspecifico.getRoteiro().getOrdenado(),
                      onChanged: (bool value) {
                        setState(() {
                          widget._objEspecifico.getRoteiro().setOrdenado(value);
                        });
                      },
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar novo roteiro",
                        textAlign: TextAlign.justify,
                      ),
                      onPressed: () {
                        chamaTelaCadastrarNovaAtividade(context, widget._objEspecifico);
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Finalizar atividade"),
                      onPressed: () {
                        chamaTelaObjEspecificos(context, widget._objEspecifico);
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

  List<ListTile> getListItems() => widget._objEspecifico.getRoteiro().getListaAtividade().asMap().map((index, atividade) => MapEntry(index, geraLista(atividade, index))).values.toList();

  ListTile geraLista(Atividade atividade, int index) => ListTile(key: ValueKey(atividade), title: Text(atividade.getAtividade()), leading: Text("#${index + 1}"), dense: true);

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      Atividade atividade = widget._objEspecifico.getRoteiro().getAtividade(oldIndex);

      widget._objEspecifico.getRoteiro().getListaAtividade().removeAt(oldIndex);
      widget._objEspecifico.getRoteiro().getListaAtividade().insert(newIndex, atividade);
    });
  }

  void chamaTelaObjEspecificos(BuildContext context, ObjEspecifico objEspecifico) {
    Navigator.pop(context, objEspecifico);
  }

  void chamaTelaCadastrarNovaAtividade(BuildContext context, ObjEspecifico objEspecifico) async {
    objEspecifico = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAtividade(objEspecifico)));
    setState(() {});
  }

  void chamaTelaVisualizarAtividade(BuildContext context, Atividade atividade) async {
    atividade = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVisualizaAtividade(atividade)));
    setState(() {});
  }
}
