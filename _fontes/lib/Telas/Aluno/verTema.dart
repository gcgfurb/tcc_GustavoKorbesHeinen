import 'package:flutter/material.dart';
import 'package:TCC_II/Telas/Aluno/visualizarRoteiroNaoDefinido.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';

class ClasseVerTema extends StatefulWidget {
  Tema _tema = new Tema();
  ClasseVerTema(this._tema);

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
                      widget._tema.getTema(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 15, 15),
                    child: Text(
                      widget._tema.getDescricao(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: widget._tema.getListaObjEspecifico().length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.bookmarks),
                        title: Text('${widget._tema.getObjEspecifico(index).getObjetivo()}'),
                        dense: true,
                        trailing: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.green[500],
                          textColor: Colors.white,
                          child: Text("Realizar atividades"),
                          onPressed: () {
                            chamaTelaRealizarAtividades(context, widget._tema.getObjEspecifico(index));
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

void chamaTelaRealizarAtividades(context, ObjEspecifico _objEspecifico) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroNaoDefinido(_objEspecifico)));
}
