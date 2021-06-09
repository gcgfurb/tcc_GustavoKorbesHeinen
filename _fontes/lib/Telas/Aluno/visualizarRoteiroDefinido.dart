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
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(5, 15, 0, 5),
              child: Text(
                'Objetivo: ' + widget._objEspecifico.getObjetivo(),
                style: TextStyle(fontSize: 30),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: widget._objEspecifico.getRoteiro().getQtdAtividades(),
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.multiple_stop),
                        title: getNomeAtividade(index),
                        dense: true,
                        trailing: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.green[500],
                          disabledColor: Colors.grey[600],
                          textColor: Colors.white,
                          child: Text(
                            widget._objEspecifico.getRoteiro().getAtividade(index).getRespostaAtividade() != null ? "Ver Resposta" : "Responder",
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: !podeHabilitarBotao(index) ? null : () => buscaAtividades(context, widget._objEspecifico.getRoteiro().getAtividade(index)),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text(
                  "Voltar",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getNomeAtividade(int index) {
    String atividade = widget._objEspecifico.getRoteiro().getAtividade(index).getNomeAtividade();
    String descricao = widget._objEspecifico.getRoteiro().getAtividade(index).getDescricao();

    String retorno = descricao.isEmpty ? atividade : (atividade + " - " + descricao);

    return Text(
      retorno,
      style: TextStyle(fontSize: 15),
    );
  }

  bool podeHabilitarBotao(int index) {
    if (index == 0) return true;

    if (widget._objEspecifico.getRoteiro().getOrdenado()) {
      if (widget._objEspecifico.getRoteiro().getAtividade(index - 1).getRespostaAtividade() != null) {
        return true;
      }
    } else
      return true;

    return false;
  }

  void buscaAtividades(BuildContext context, Atividade atividade) async {
    await Util.escolheAtividadeCorreta(context, atividade);
    setState(() {});
  }
}
