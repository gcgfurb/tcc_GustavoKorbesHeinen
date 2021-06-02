import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseRoteiroNaoDefinido extends StatefulWidget {
  ObjEspecifico _objEspecifico = new ObjEspecifico();
  ClasseRoteiroNaoDefinido(this._objEspecifico);

  @override
  CadastrarRoteiroNaoDefinido createState() => CadastrarRoteiroNaoDefinido();
}

class CadastrarRoteiroNaoDefinido extends State<ClasseRoteiroNaoDefinido> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                    child: Text(
                      'Objetivo: ' + widget._objEspecifico.getObjetivo(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 15, 5),
                  alignment: Alignment.topRight,
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
                            Atividade atividade = new Atividade();
                            atividade.setNomeAtividade(_listCaracteristicas[index]);
                            atividade.setId(index);
                            chamaTelaCadastrarNovaPergunta(context, atividade);
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
                          child: ListView(
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar outra pergunta",
                        textAlign: TextAlign.justify,
                      ),
                      onPressed: () {
                        Atividade atividade = new Atividade();
                        atividade.setNomeAtividade("Pergunta personalizada");
                        atividade.setId(-1);
                        chamaTelaCadastrarNovaPergunta(context, atividade);
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

  List<ListTile> getListItems() => widget._objEspecifico.getRoteiro().getListaAtividade().asMap().map((index, atividade) => MapEntry(index, geraLista(atividade, index))).values.toList();

  ListTile geraLista(Atividade atividade, int index) =>
      ListTile(key: ValueKey(atividade), title: Text(atividade.getNomeAtividade().isNotEmpty ? atividade.getNomeAtividade() : "Pergunta Personalizada"), leading: Text("#${index + 1}"), dense: true);

  void chamaTelaObjEspecificos(BuildContext context) {
    Navigator.pop(context);
  }

  void chamaTelaCadastrarNovaPergunta(BuildContext context, Atividade atividade) async {
    await Util.escolheAtividadeCorreta(context, atividade);
    if (atividade.getRespostaAtividade() != null) widget._objEspecifico.getRoteiro().adicionaAtividade(atividade);
    setState(() {});
  }
}
