import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';

class ClasseRoteiroDefinido extends StatefulWidget {
  ObjEspecifico _objEspecifico = new ObjEspecifico();
  ClasseRoteiroDefinido(this._objEspecifico);

  @override
  VisualizarRoteiroDefinido createState() => VisualizarRoteiroDefinido();
}

class VisualizarRoteiroDefinido extends State<ClasseRoteiroDefinido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: Text(
                  'Objetivo: ' + widget._objEspecifico.getObjetivo(),
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 270,
              child: ListView.builder(
                  itemCount: widget._objEspecifico.getRoteiro().getQtdAtividades(),
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.bookmarks),
                        title: Text(widget._objEspecifico.getRoteiro().getAtividade(index).getNomeAtividade() + " - " + widget._objEspecifico.getRoteiro().getAtividade(index).getDescricao()),
                        dense: true,
                        trailing: RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.green[500],
                            disabledColor: Colors.grey[600],
                            textColor: Colors.white,
                            child: Text(widget._objEspecifico.getRoteiro().getAtividade(index).respostaAtividade != null ? "Ver Resposta" : "Responder"),
                            onPressed: !podeHabilitarBotao(index) ? null : () => buscaAtividades(context, widget._objEspecifico.getRoteiro().getAtividade(index))),
                      ),
                    );
                  }),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0, 10, 15, 0),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
    );
  }

  bool podeHabilitarBotao(int index) {
    if (index == 0) return true;

    if (widget._objEspecifico.getRoteiro().getOrdenado()) {
      if (widget._objEspecifico.getRoteiro().getAtividade(index - 1).respostaAtividade != null) {
        return true;
      }
    } else
      return true;

    return false;
  }

  void buscaAtividades(BuildContext context, Atividade atividade) async {
    setState(() {
      Util.escolheAtividadeCorreta(context, atividade);
    });
  }

  void chamaTelaObjEspecificos(BuildContext context) {
    Navigator.pop(context);
  }
}
