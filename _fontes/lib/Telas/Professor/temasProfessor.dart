import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:teste/Telas/aprendaUsar.dart';
import '../telaInicial.dart';
import 'cadastrarTema.dart';
import '../../Classes/Tema.dart';

class ClasseProfessor extends StatefulWidget {
  @override
  TemasProfessor createState() => TemasProfessor();
}

class TemasProfessor extends State<ClasseProfessor> {
  List<Tema> _aTemas = carregaTemas();
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
                        data: _aTemas[_index].getTema(),
                        size: 200,
                      ),
                      color: Colors.green[300],
                      onPressed: () {
                        setState(() {
                          chamaTelaCadastrarTema(context, _aTemas[_index]);
                        });
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
                          setState(() {
                            chamaTelaCadastrarTema(context, _aTemas[_aTemas.length - 1]);
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
    tema = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseTema(tema)));
    setState(() {});
  }

  void chamaTelaAprendaAUsar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAprendaUsar()));
  }

  void chamaTelaInicial(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseTelaInicial()));
  }

  void abreQRCode() {}
}

List<Tema> carregaTemas() {
  List<Tema> temas = new List();
/*
  for (int idx = 0; idx < 5; idx++) {
    Tema temaAtual = new Tema();
    temaAtual.SetDescricao("Teste" + idx.toString());
    temas.add(temaAtual);
  }
*/
  return temas;
}
