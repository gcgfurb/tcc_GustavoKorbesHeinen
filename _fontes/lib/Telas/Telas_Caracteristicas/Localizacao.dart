import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseLocalizacao extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseLocalizacao(this._atividade);

  @override
  Localizacao createState() => Localizacao();
}

class Localizacao extends State<ClasseLocalizacao> {
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
