import 'package:flutter/material.dart';

class ClasseSobre extends StatefulWidget {
  @override
  Sobre createState() => Sobre();
}

class Sobre extends State<ClasseSobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                "Aplicativo Habitat 2021",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
                maxLines: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                "Desenvolvido por: Gustavo Korbes Heinen",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
                maxLines: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                "Auxilios no desenvolvimento: ...",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
                maxLines: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                "Versão do sistema: 0.0.1",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
                maxLines: 12,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 25),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text("Voltar"),
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
}
