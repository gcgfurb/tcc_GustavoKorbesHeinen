import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseDesenho extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseDesenho(this._atividade);

  @override
  Desenho createState() => Desenho();
}

class Desenho extends State<ClasseDesenho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Implementação não realizada",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              width: 150,
              padding: EdgeInsets.all(15),
              child: FloatingActionButton.extended(
                heroTag: "btCancelar",
                label: Text(
                  "Cancelar",
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.red,
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
