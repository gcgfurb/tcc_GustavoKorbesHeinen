import 'package:flutter/material.dart';

class ClasseAprendaUsar extends StatefulWidget {
  @override
  AprendaAUsar createState() => AprendaAUsar();
}

class AprendaAUsar extends State<ClasseAprendaUsar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                "Este aplicativo tem como funcionalidade a disponibilização da realização de apoio para atividades de saídas a campo em Clubes de Ciências.\nComo professor, seu objeitvo é cadastrar temas, objetivos específicos, roteiros e atividades para que os Clubistas possam atuar e trabalhar em cada atividade.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
                maxLines: 12,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 25),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text(
                  "Voltar",
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
}
