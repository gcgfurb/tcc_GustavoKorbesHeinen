import 'package:flutter/material.dart';
import 'realizarLogin.dart';

class ClasseTelaInicial extends StatefulWidget {
  @override
  TelaInicial createState() => TelaInicial();
}

class TelaInicial extends State<ClasseTelaInicial> {
  bool bProfessor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.topRight,
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  color: Colors.green[500],
                  textColor: Colors.white,
                  child: Text("Sou Professor"),
                  onPressed: () {
                    bProfessor = true;
                    chamaTelaLogin(context, bProfessor);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                  textColor: Colors.white,
                  color: Colors.green[500],
                  child: Text("Sou Aluno"),
                  onPressed: () {
                    bool bProfessor = false;
                    chamaTelaLogin(context, bProfessor);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                  textColor: Colors.white,
                  color: Colors.green[500],
                  child: Text("Configurações"),
                  onPressed: () {},
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
                  textColor: Colors.white,
                  color: Colors.green[500],
                  child: Text("Sair"),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void chamaTelaLogin(BuildContext context, bool bProfessor) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRealizarLogin(bProfessor)));
  }
}
