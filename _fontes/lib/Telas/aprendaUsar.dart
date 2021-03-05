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
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade Este aplicativo tem como funcionalidade.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
              maxLines: 12,
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(top: 25),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text("Voltar"),
                onPressed: () {
                  chamaTelaInicial(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void chamaTelaInicial(BuildContext context) {
  Navigator.pop(context);
}
