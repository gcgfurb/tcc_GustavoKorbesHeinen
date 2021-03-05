import 'package:flutter/material.dart';
import 'package:teste/Telas/Aluno/visualizarRoteiroNaoDefinido.dart';

class ClasseVerTema extends StatefulWidget {
  @override
  VerTema createState() => VerTema();
}

class VerTema extends State<ClasseVerTema> {
  final itens = List<String>.generate(10000, (index) => "Objetivo $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 5, 15),
                    child: Text(
                      "Tema: XXX",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 15, 15),
                    child: Text(
                      "Descrição: YYY",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: itens.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.bookmarks),
                        title: Text('${itens[index]}'),
                        dense: true,
                        trailing: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.green[500],
                          textColor: Colors.white,
                          child: Text("Realizar atividades"),
                          onPressed: () {
                            chamaTelaRealizarAtividades(context);
                          },
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0, 10, 15, 0),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text("Enviar respostas ao Professor"),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void chamaTelaRealizarAtividades(context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroNaoDefinido()));
}
