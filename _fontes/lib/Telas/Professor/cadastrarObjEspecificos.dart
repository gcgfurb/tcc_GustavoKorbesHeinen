import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'cadastrarRoteiro.dart';

class ClasseObjEspecifico extends StatefulWidget {
  Tema temaAtual = new Tema();
  ClasseObjEspecifico(this.temaAtual);

  @override
  CadastrarObjEspecificos createState() => CadastrarObjEspecificos();
}

class CadastrarObjEspecificos extends State<ClasseObjEspecifico> {
  TextEditingController objTexto = new TextEditingController();

  FocusNode focusNodeObj;

  @override
  void initState() {
    super.initState();
    focusNodeObj = FocusNode();
  }

  @override
  void dispose() {
    focusNodeObj.dispose();
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
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: TextField(
                      focusNode: focusNodeObj,
                      controller: objTexto,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cadastrar Objetivo',
                        hintText: 'Digite um Objetivo',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Cadastrar Objetivo"),
                      onPressed: () {
                        if (objTexto.text.isEmpty) {
                          focusNodeObj.requestFocus();
                        } else {
                          cadastrarObjetivo();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: widget.temaAtual.getListaObjEspecifico().length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.bookmarks),
                        title: Text(widget.temaAtual.getObjEspecifico(index).getObjetivo()),
                        dense: true,
                        trailing: Wrap(
                          spacing: 12,
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.green[500],
                              textColor: Colors.white,
                              child: Text("Cadastrar Roteiro"),
                              onPressed: () {
                                chamaTelaCadastrarRoteiro(context, widget.temaAtual.getObjEspecifico(index));
                              },
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.delete_forever,
                                size: 50,
                              ),
                              onPressed: () {
                                chamaDialogExcluirObjEspecifico(context, index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text("Finalizar Cadastro de Objetivos"),
                onPressed: () {
                  chamaTelaCadastrarTema(context, widget.temaAtual);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void chamaDialogExcluirObjEspecifico(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Deletar objetivo e roteiros"),
        content: Text("Deseja excluir o objetivo? O roteiro também irá ser excluído."),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Não"),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text("Sim"),
            onPressed: () {
              excluirObjetivo(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void excluirObjetivo(int index) {
    setState(() {
      widget.temaAtual.removeObjEspecifico(index);
    });
  }

  void cadastrarObjetivo() {
    ObjEspecifico obj = new ObjEspecifico();
    obj.setObjetivo(objTexto.text);
    widget.temaAtual.adicionaObjEspecifico(obj);
    objTexto.clear();
    setState(() {});
  }

  void chamaTelaCadastrarRoteiro(BuildContext context, ObjEspecifico objEspecifico) async {
    objEspecifico = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiro(objEspecifico)));
    setState(() {});
  }
}

void chamaTelaCadastrarTema(BuildContext context, Tema temaAtual) {
  Navigator.pop(context, temaAtual);
}
