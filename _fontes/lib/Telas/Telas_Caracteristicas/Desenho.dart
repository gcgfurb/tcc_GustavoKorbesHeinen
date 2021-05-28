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
        child: Center(
          child: Text("Implementação não realizada"),
        ),
      ),
    );
  }
}
