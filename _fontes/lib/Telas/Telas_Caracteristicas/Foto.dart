import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseFoto extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseFoto(this._atividade);

  @override
  Foto createState() => Foto();
}

class Foto extends State<ClasseFoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.green[300],
        //Utilizar camêra, tela
        /*
         ________________________________________________________________
        |  ______________________________     _________________________  |
        | |                              |   |                         | |
        | |                              |   |      Descrição          | |
        | |        Imagem aqui           |   |                         | |
        | |                              |   |                         | |
        | |                              |   |                         | |
        | |                              |   |_________________________| |
        | |                              |                               |
        | |                              |                               |
        | |                              |   Alterar imagem              |
        | |______________________________|   Gravar Cancelar             |
        |________________________________________________________________|*/
      ),
    );
  }
}
