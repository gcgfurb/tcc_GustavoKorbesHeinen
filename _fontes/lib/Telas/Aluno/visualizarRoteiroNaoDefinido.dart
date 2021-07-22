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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                  child: Text(
                    'Objetivo: ' + widget._objEspecifico.getObjetivo(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
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
                              Atividade atividade = new Atividade();
                              if (_listCaracteristicas[index] == "Personalizada") {
                                atividade.setNomeAtividade("Pergunta personalizada");
                                atividade.setId(-1);
                              } else {
                                atividade.setNomeAtividade(_listCaracteristicas[index]);
                                if (index > 11) index++;
                                atividade.setId(index);
                              }
                              chamaTelaCadastrarNovaPergunta(context, atividade);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: getListItems(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text(
                  "Finalizar atividade",
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

  List<ListTile> getListItems() => widget._objEspecifico.getRoteiro().getListaAtividade().asMap().map((index, atividade) => MapEntry(index, geraLista(atividade, index))).values.toList();

  ListTile geraLista(Atividade atividade, int index) => ListTile(
      key: ValueKey(atividade),
      title: Text(
        "#${index + 1} - " + (atividade.getNomeAtividade().isNotEmpty ? atividade.getNomeAtividade() : "Pergunta Personalizada"),
        style: TextStyle(fontSize: 18),
      ),
      contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
      dense: true);

  void chamaTelaCadastrarNovaPergunta(BuildContext context, Atividade atividade) async {
    await Util.escolheAtividadeCorreta(context, atividade);
    if (atividade.getRespostaAtividade() != null) widget._objEspecifico.getRoteiro().adicionaAtividade(atividade);
    setState(() {});
  }
}
