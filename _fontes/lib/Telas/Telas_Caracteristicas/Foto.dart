import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaFoto.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:image_picker/image_picker.dart';

class ClasseFoto extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseFoto(this._atividade);

  @override
  Foto createState() => Foto();
}

class Foto extends State<ClasseFoto> {
  TextEditingController _textoDescricao;
  PickedFile _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          children: <Widget>[
            _decideImageView(),
            Expanded(
              child: IntrinsicWidth(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextField(
                        controller: _textoDescricao,
                        maxLength: 150,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: 'Objetivo geral da atividade de campo',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                        color: Colors.green[500],
                        textColor: Colors.white,
                        child: Text("Alterar imagem"),
                        onPressed: () {
                          _openCamera(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 150,
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                              color: Colors.green[500],
                              textColor: Colors.white,
                              child: Text("Gravar"),
                              onPressed: () {
                                CaracteristicaFoto _caracteristicaFoto = new CaracteristicaFoto(_imageFile, _textoDescricao.text);
                                widget._atividade.adicionaResposta(_caracteristicaFoto);
                                chamaTelaVisualizaRoteiro(context);
                              },
                            ),
                          ),
                          Container(
                            width: 150,
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                              color: Colors.green[500],
                              textColor: Colors.white,
                              child: Text("Cancelar"),
                              onPressed: () {
                                chamaTelaVisualizaRoteiro(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dynamic foto = widget._atividade.respostaAtividade;

    _textoDescricao = new TextEditingController(text: foto.getDescricao());
    _imageFile = foto.getImageFile();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    this.setState(() {
      _imageFile = picture;
    });
  }

  Widget _decideImageView() {
    if (_imageFile == null) {
      return Expanded(
        child: Center(
          child: Text("Nenhuma imagem no momento"),
        ),
      );
    } else {
      return Expanded(
          child: Image.file(
        File(_imageFile.path),
        width: 400,
        height: 400,
      ));
    }
  }
}

chamaTelaVisualizaRoteiro(BuildContext context) {
  Navigator.pop(context);
}
