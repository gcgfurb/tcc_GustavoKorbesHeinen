import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Telas/Professor/visualizaAtividade.dart';
import 'cadastraNovaAtividade.dart';

class ClasseRoteiro extends StatefulWidget {
  ObjEspecifico objEspecifico = new ObjEspecifico();
  ClasseRoteiro(this.objEspecifico);

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
                      'Objetivo: ' + widget.objEspecifico.getObjetivo(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
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
                      crossAxisCount: 4,
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
                            chamaTelaCadastrarNovaAtividade(context, widget.objEspecifico.getRoteiro(), _listCaracteristicas[index]);
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
                      value: widget.objEspecifico.getRoteiro().getOrdenado(),
                      onChanged: (bool value) {
                        setState(() {
                          widget.objEspecifico.getRoteiro().setOrdenado(value);
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
                        chamaTelaCadastrarNovaAtividade(context, widget.objEspecifico.getRoteiro(), "");
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
                        Navigator.pop(context, widget.objEspecifico);
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

  List<ListTile> getListItems() => widget.objEspecifico.getRoteiro().getListaAtividade().asMap().map((index, atividade) => MapEntry(index, geraLista(atividade, index))).values.toList();

  ListTile geraLista(Atividade atividade, int index) => ListTile(
        key: ValueKey(atividade),
        title: Text("#${index + 1} - " + atividade.getNomeAtividade() + " - " + atividade.getDescricao()),
        contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
        dense: true,
        trailing: TextButton(
          child: Icon(Icons.edit),
          onPressed: () async {
            chamaDialogAlterarExcluir(context, atividade, index);
          },
        ),
      );

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      Atividade atividade = widget.objEspecifico.getRoteiro().getAtividade(oldIndex);

      widget.objEspecifico.getRoteiro().getListaAtividade().removeAt(oldIndex);
      widget.objEspecifico.getRoteiro().getListaAtividade().insert(newIndex, atividade);
    });
  }

  void chamaDialogAlterarExcluir(BuildContext context, Atividade atividade, int idx) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Ação"),
        content: Text("Deseja alterar ou excluir a atividade: " + atividade.getNomeAtividade()),
        actions: <Widget>[
          CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Alterar"),
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVisualizaAtividade(atividade)));
                Navigator.pop(context);
                setState(() {});
              }),
          CupertinoDialogAction(
            child: Text("Excluir"),
            onPressed: () {
              setState(() {
                widget.objEspecifico.getRoteiro().removeAtividade(idx);
              });

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void chamaTelaCadastrarNovaAtividade(BuildContext context, Roteiro roteiro, String _caracteristica) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAtividade(roteiro, _caracteristica)));
    setState(() {});
  }
}
