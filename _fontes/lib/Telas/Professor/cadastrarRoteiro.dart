import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Atividade.dart';
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
    //'Desenhar',
    'Ficha Coleta',
    'Lixo',
    'Sons da Natureza',
    'Localização',
    'Produção de Material',
    'Outra intervenção',
    'Plantar',
    'Personalizada'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Text(
                'Objetivo: ' + widget.objEspecifico.getObjetivo(),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 5,
                      scrollDirection: Axis.vertical,
                      primary: false,
                      children: List.generate(
                        _listCaracteristicas.length,
                        (index) {
                          return TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[500],
                              primary: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _listCaracteristicas[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              //if (index > 11) index++;
                              String nomeAtividade = _listCaracteristicas[index];
                              if (nomeAtividade == 'Personalizada') nomeAtividade = '';
                              chamaTelaCadastrarNovaAtividade(context, new Atividade(), nomeAtividade);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReorderableListView(
                      onReorder: onReorder,
                      children: getListItems(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: CheckboxListTile(
                      title: Text(
                        "Este roteiro deve ser realizado na ordem proposta",
                        style: TextStyle(fontSize: 20),
                      ),
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
                    height: 70,
                    padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                    child: RaisedButton(
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Finalizar atividade",
                        style: TextStyle(fontSize: 20),
                      ),
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
        title: Text(
          "#${index + 1} - " + atividade.getNomeAtividade() + " - " + atividade.getDescricao(),
          style: TextStyle(fontSize: 18),
        ),
        contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
        dense: true,
        trailing: TextButton(
          child: Icon(Icons.edit),
          style: TextButton.styleFrom(
            primary: Colors.black54,
          ),
          onPressed: () async {
            chamaDialogAlterarExcluir(context, atividade, atividade.getNomeAtividade(), index);
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

  void chamaDialogAlterarExcluir(BuildContext context, Atividade atividade, String nomeAtividade, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Ação"),
        content: Text("Deseja alterar ou excluir a atividade: " + nomeAtividade),
        actions: <Widget>[
          CupertinoDialogAction(
              child: Text("Alterar"),
              onPressed: () async {
                Atividade novo = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAtividade(atividade, nomeAtividade)));
                if (novo != null) {
                  widget.objEspecifico.getRoteiro().getAtividade(index).setNomeAtividade(novo.getNomeAtividade());
                  widget.objEspecifico.getRoteiro().getAtividade(index).setDescricao(novo.getDescricao());
                }
                Navigator.pop(context);
                setState(() {});
              }),
          CupertinoDialogAction(
            child: Text("Excluir"),
            onPressed: () {
              setState(() {
                widget.objEspecifico.getRoteiro().removeAtividade(index);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void chamaTelaCadastrarNovaAtividade(BuildContext context, Atividade atividade, String _caracteristica) async {
    Atividade novo = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAtividade(atividade, _caracteristica)));
    if (novo != null) widget.objEspecifico.getRoteiro().adicionaAtividade(novo);
    setState(() {});
  }
}
