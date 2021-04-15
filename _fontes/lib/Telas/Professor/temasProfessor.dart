import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:TCC_II/Telas/aprendaUsar.dart';
import '../telaInicial.dart';
import 'cadastrarTema.dart';
import '../../Classes/InfoTema.dart';
import '../../Classes/Tema.dart';

class ClasseProfessor extends StatefulWidget {
  @override
  TemasProfessor createState() => TemasProfessor();
}

class TemasProfessor extends State<ClasseProfessor> {
  List<Tema> _aTemas = [];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_aTemas.length > 0)
                    Text(
                      _aTemas[_index].getTema(),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                  if (_aTemas.length > 0)
                    FlatButton(
                      child: QrImage(
                        backgroundColor: Colors.green[500],
                        data: carregaInfo(),
                        size: 200,
                      ),
                      color: Colors.green[300],
                      onPressed: () {
                        chamaTelaCadastrarTema(context, _aTemas[_index]);
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
                        color: Colors.green[500],
                        textColor: Colors.white,
                        child: Text("Cadastrar Novo Tema"),
                        onPressed: () {
                          _aTemas.add(new Tema());
                          chamaTelaCadastrarTema(context, _aTemas[_aTemas.length - 1]);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
                        textColor: Colors.white,
                        color: Colors.green[500],
                        child: Text("Próximo Tema"),
                        onPressed: () {
                          setState(() {
                            _index == _aTemas.length - 1 ? _index = 0 : _index++;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
                        textColor: Colors.white,
                        color: Colors.green[500],
                        child: Text("Tema Anterior"),
                        onPressed: () {
                          setState(() {
                            _index == 0 ? _index = _aTemas.length - 1 : _index--;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
                        textColor: Colors.white,
                        color: Colors.green[500],
                        child: Text("Aprenda a Usar"),
                        onPressed: () {
                          chamaTelaAprendaAUsar(context);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
                        textColor: Colors.white,
                        color: Colors.green[500],
                        child: Text("Voltar à Tela Inicial"),
                        onPressed: () {
                          chamaTelaInicial(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void chamaTelaCadastrarTema(BuildContext context, Tema tema) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseTema(tema)));
    setState(() {});
  }

  void chamaTelaAprendaAUsar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAprendaUsar()));
  }

  void chamaTelaInicial(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseTelaInicial()));
  }

  String carregaInfo() {
    Tema temaAtual = _aTemas[_index];

    List<String> info = [];

    String infoAtual = temaAtual.getTema() + "¨§" + temaAtual.getDescricao() + "¨§" + temaAtual.getListaObjEspecifico().length.toString() + "¨§";

    for (ObjEspecifico it in temaAtual.getListaObjEspecifico()) {
      infoAtual += it.getObjetivo() + "¨§";
      infoAtual += it.getRoteiro().getOrdenado().toString() + "¨§";
      infoAtual += it.getRoteiro().getQtdAtividades().toString() + "¨§";

      for (Atividade it in it.getRoteiro().getListaAtividade()) {
        infoAtual += it.getId().toString() + "¨§" + it.getNomeAtividade() + "¨§" + it.getDescricao() + "¨§";

        if (infoAtual.length > 2500) {
          info.add(infoAtual);
          infoAtual = "";
        }
      }
    }

    info.add(infoAtual);

    InfoTema infoTema = new InfoTema(info);

    return infoTema.getInfoEspecifica(0);
  }
}
