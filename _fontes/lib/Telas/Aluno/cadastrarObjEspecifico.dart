import 'package:TCC_II/Telas/Aluno/visualizarRoteiroNaoDefinido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Tema.dart';

class ClasseObjEspecifico extends StatefulWidget {
  Tema temaAtual = new Tema();
  ClasseObjEspecifico(this.temaAtual);

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
                  flex: 3,
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
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar Objetivo",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (validaCampos()) {
                          FocusManager.instance.primaryFocus.unfocus();
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
                        leading: Icon(Icons.now_widgets_outlined),
                        title: Text(
                          widget.temaAtual.getObjEspecifico(index).getObjetivo(),
                          style: TextStyle(fontSize: 15),
                        ),
                        dense: true,
                        trailing: Wrap(
                          spacing: 12,
                          children: <Widget>[
                            RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.green[500],
                              textColor: Colors.white,
                              child: Text(
                                "Cadastrar Pergunta",
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus.unfocus();
                                chamaTelaCadastrarRoteiro(context, widget.temaAtual.getObjEspecifico(index));
                              },
                            ),
                            if (!widget.temaAtual.getObjDefinido())
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.delete_forever,
                                  size: 50,
                                ),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus.unfocus();
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text(
                  "Finalizar Cadastro de Objetivos",
                  style: TextStyle(fontSize: 20),
                ),
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
    obj.setObjetivo(_tecObjetivo.text);
    widget.temaAtual.adicionaObjEspecifico(obj);
    _tecObjetivo.clear();
    setState(() {});
  }

  void chamaTelaCadastrarRoteiro(BuildContext context, ObjEspecifico _objEspecifico) async {
    _objEspecifico = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroNaoDefinido(_objEspecifico)));
    setState(() {});
  }

  bool validaCampos() {
    if (_tecObjetivo.text.isEmpty) {
      _fnObjetivo.requestFocus();
      return false;
    }

    return true;
  }

  void chamaTelaCadastrarTema(BuildContext context, Tema temaAtual) {
    Navigator.pop(context, temaAtual);
  }
}
