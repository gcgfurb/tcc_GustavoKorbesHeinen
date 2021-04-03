import 'package:flutter/material.dart';

import 'package:TCC_II/Classes/Atividade.dart';

class ClasseAudio extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseAudio(this._atividade);

  @override
  Audio createState() => Audio();
}

class Audio extends State<ClasseAudio> {
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
