import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaMedida.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseMedida extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseMedida(this._atividade);

  @override
  Medida createState() => Medida();
}

class Medida extends State<ClasseMedida> {
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
