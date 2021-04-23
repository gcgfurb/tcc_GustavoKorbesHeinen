import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaAudio.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseSonsDaNatureza extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseSonsDaNatureza(this._atividade);

  @override
  SonsDaNatureza createState() => SonsDaNatureza();
}

class SonsDaNatureza extends State<ClasseSonsDaNatureza> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      ),
    );
  }
}
