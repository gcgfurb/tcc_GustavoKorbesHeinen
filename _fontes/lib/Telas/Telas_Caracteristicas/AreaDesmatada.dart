import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaAreaDesmatada.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseAreaDesmatada extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseAreaDesmatada(this._atividade);

  @override
  AreaDesmatada createState() => AreaDesmatada();
}

class AreaDesmatada extends State<ClasseAreaDesmatada> {
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
