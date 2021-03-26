import 'package:TCC_II/Telas/Aluno/visualizarRoteiroDefinido.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';

class ClasseVerTema extends StatefulWidget {
  Tema _tema = new Tema();
  ClasseVerTema(this._tema);

  @override
  VerTema createState() => VerTema();
}

class VerTema extends State<ClasseVerTema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: Text(
                  'Tema: ' + widget._tema.getTema(),
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: Text(
                  'Descrição: ' + widget._tema.getDescricao(),
                  style: TextStyle(fontSize: 25),
                ),
              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text("Enviar respostas ao Professor"),
                    onPressed: () {},
                  ),
                ),
                if (!widget._tema.getRoteiroDefinido())
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Cadastrar novo Objetivo Específico"),
                      onPressed: () {},
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void chamaTelaRealizarAtividades(context, ObjEspecifico _objEspecifico) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroDefinido(_objEspecifico)));
}
