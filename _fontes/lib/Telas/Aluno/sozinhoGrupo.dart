import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'cadastrarGrupo.dart';
import 'verTema.dart';

class ClasseSozinhoGrupo extends StatefulWidget {
  Tema _tema = new Tema();
  ClasseSozinhoGrupo(this._tema);

  @override
  SozinhoGrupo createState() => SozinhoGrupo();
}

class SozinhoGrupo extends State<ClasseSozinhoGrupo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "Vou realizar as atividades:",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  color: Colors.green[500],
                  textColor: Colors.white,
                  child: Text("Sozinho"),
                  onPressed: () {
                    chamaTelaVerTema(context, widget._tema);
                  },
                ),
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  color: Colors.green[500],
                  textColor: Colors.white,
                  child: Text("Em grupo"),
                  onPressed: () {
                    chamaTelaEmGrupo(context, widget._tema);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void chamaTelaVerTema(BuildContext context, Tema tema) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVerTema(tema)));
}

void chamaTelaEmGrupo(BuildContext context, Tema tema) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCadastrarGrupo(tema)));
}
