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
              padding: EdgeInsets.only(top: 20),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  "Este aplicativo tem como funcionalidade a disponibilização da realização de apoio para atividades de saídas a campo em Clubes de Ciências." +
                      "\nComo professor, seu objeitvo é cadastrar temas, objetivos específicos, roteiros e atividades para que os Clubistas possam atuar e trabalhar em cada atividade." +
                      " Caso não seja cadastrado nenhum Objetivo Específico ou Atividade por parte do Professor, o Clubista pode detalhar Objetivos Específicos, Roteiros e Atividades encontrados no meio da natureza.\n" +
                      "Como Clubista, você pode responder as atividades cadastradas pelo Professor ou criá-las caso o Professor não as tenha criado. Desta forma o Clubista fica livre a cadastrar qualquer atividade encontrada na natureza",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
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
