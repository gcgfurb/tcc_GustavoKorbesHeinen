import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'cadastrarRoteiro.dart';

class ClasseObjEspecifico extends StatefulWidget {
  Tema tema = new Tema();
  ClasseObjEspecifico(this.tema);

  @override
  CadastrarObjEspecificos createState() => CadastrarObjEspecificos();
}

class CadastrarObjEspecificos extends State<ClasseObjEspecifico> {
  TextEditingController _tecObjetivo = new TextEditingController();
  FocusNode _fnObjetivo;

  @override
  void initState() {
    super.initState();
    _fnObjetivo = FocusNode();
  }

  @override
  void dispose() {
    _fnObjetivo.dispose();
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
                    padding: EdgeInsets.fromLTRB(15, 15, 5, 0),
                    child: TextField(
                      focusNode: _fnObjetivo,
                      controller: _tecObjetivo,
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
                    padding: EdgeInsets.fromLTRB(5, 15, 15, 0),
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        color: Colors.green[500],
                        textColor: Colors.white,
                        child: Text("Cadastrar Objetivo"),
                        onPressed: () {
                          if (validaCampos()) {
                            FocusManager.instance.primaryFocus.unfocus();
                            cadastrarObjetivo();
                          }
                        }),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: widget.tema.getListaObjEspecifico().length,
                itemBuilder: (context, index) {
                  return Container(
                    color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                    child: ListTile(
                      leading: Icon(Icons.bookmarks),
                      title: Text(widget.tema.getObjEspecifico(index).getObjetivo()),
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
                              chamaTelaCadastrarRoteiro(context, widget.tema.getObjEspecifico(index));
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
                },
              ),
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
                  chamaTelaCadastrarTema(context);
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
      widget.tema.removeObjEspecifico(index);
    });
  }

  void cadastrarObjetivo() {
    ObjEspecifico obj = new ObjEspecifico();
    obj.setObjetivo(_tecObjetivo.text);
    widget.tema.adicionaObjEspecifico(obj);
    _tecObjetivo.clear();
    setState(() {});
  }

  void chamaTelaCadastrarRoteiro(BuildContext context, ObjEspecifico objEspecifico) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiro(objEspecifico)));
    setState(() {});
  }

  bool validaCampos() {
    if (_tecObjetivo.text.isEmpty) {
      _fnObjetivo.requestFocus();
      return false;
    }

    return true;
  }
}

void chamaTelaCadastrarTema(BuildContext context) {
  Navigator.pop(context);
}
