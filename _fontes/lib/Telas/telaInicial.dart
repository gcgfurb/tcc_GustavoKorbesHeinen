import 'package:TCC_II/Telas/Professor/aprendaUsar.dart';
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
        alignment: Alignment.center,
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.green[500],
                  textColor: Colors.white,
                  child: Text(
                    "Sou Professor",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    bProfessor = true;
                    chamaTelaLogin(context, bProfessor);
                  },
                ),
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  textColor: Colors.white,
                  color: Colors.green[500],
                  child: Text(
                    "Sou Clubista",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    bProfessor = false;
                    chamaTelaLogin(context, bProfessor);
                  },
                ),
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  textColor: Colors.white,
                  color: Colors.green[500],
                  child: Text(
                    "Sobre",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationVersion: '1.0.1',
                      applicationLegalese: 'Desenvolvido por: Gustavo Korbes Heinen\nAuxílios externos: Lucas Serodio Gonçalves,\nBruna Hamann',
                    );
                  },
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
