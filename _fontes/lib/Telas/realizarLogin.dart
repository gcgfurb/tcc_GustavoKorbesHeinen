import 'package:flutter/material.dart';
import 'Aluno/carregarTema.dart';
import 'Professor/temasProfessor.dart';

class ClasseRealizarLogin extends StatefulWidget {
  bool bProfessor = false;
  ClasseRealizarLogin(this.bProfessor);

  @override
  RealizarLogin createState() => RealizarLogin();
}

class RealizarLogin extends State<ClasseRealizarLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Faça login com sua conta da Google",
              style: TextStyle(fontSize: 30),
            ),
            Container(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text("Realizar login"),
                onPressed: () {
                  chamaAPIGoogle(context, widget.bProfessor);
                },
              ),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 70),
            ),
            Text("Caso você não tenha conta na Google, faça seu cadastro."),
          ],
        ),
      ),
    );
  }
}

void chamaAPIGoogle(BuildContext context, bool bProfessor) {
  if (bProfessor) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseProfessor()));
  } else {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCarregarTema()));
  }
}
