import 'package:flutter/material.dart';
import 'cadastrarGrupo.dart';
import 'verTema.dart';

class ClasseSozinhoGrupo extends StatefulWidget {
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
                    chamaTelaVerTema(context);
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
                    chamaTelaEmGrupo(context);
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

void chamaTelaVerTema(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVerTema()));
}

void chamaTelaEmGrupo(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCadastrarGrupo()));
}
