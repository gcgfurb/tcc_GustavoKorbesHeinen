import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Telas/Professor/visualizaAtividade.dart';
import 'cadastraNovaAtividade.dart';

class ClasseRoteiro extends StatefulWidget {
  ObjEspecifico _objEspecifico = new ObjEspecifico();
  ClasseRoteiro(this._objEspecifico);

  @override
  CadastrarRoteiro createState() => CadastrarRoteiro();
}

class CadastrarRoteiro extends State<ClasseRoteiro> {
  List<String> _listCaracteristicas = [
    'Foto',
    'Medida',
    'Solo',
    'Interação',
    'Área desmatada',
    'Vídeo',
    'Característica',
    'Lupa',
    'Vivência',
    'Mosquito',
    'Áudio',
    'Teste',
    'Desenhar',
    'Ficha Coleta',
    'Lixo',
    'Sons da Natureza',
    'Localização',
    'Produção de Material',
    'Outra intervenção',
    'Plantar'
  ];

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
                  Expanded(
                    flex: 2,
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      scrollDirection: Axis.vertical,
                      primary: false,
                      children: List.generate(_listCaracteristicas.length, (index) {
                        return RaisedButton(
                          color: Colors.green[500],
                          textColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _listCaracteristicas[index],
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          onPressed: () {
                            chamaTelaCadastrarNovaAtividade(context, widget._objEspecifico.getRoteiro(), _listCaracteristicas[index]);
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
                        "Cadastrar Atividade",
                        textAlign: TextAlign.justify,
                      ),
                      onPressed: () {
                        chamaTelaCadastrarNovaAtividade(context, widget._objEspecifico.getRoteiro(), "");
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

  ListTile geraLista(Atividade atividade, int index) => ListTile(key: ValueKey(atividade), title: Text(atividade.getDescricao()), leading: Text("#${index + 1}"), dense: true);

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

  void chamaTelaCadastrarNovaAtividade(BuildContext context, Roteiro roteiro, String _caracteristica) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAtividade(roteiro, _caracteristica)));
    setState(() {});
  }

  void chamaTelaVisualizarAtividade(BuildContext context, Roteiro roteiro, String _caracteristica) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVisualizaAtividade(roteiro, _caracteristica)));
    setState(() {});
  } //Ninguem chamando esse método por enquanto, nem a classe
}
