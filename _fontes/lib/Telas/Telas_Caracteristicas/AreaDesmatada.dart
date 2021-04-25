import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaAreaDesmatada.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:image_picker/image_picker.dart';

class ClasseAreaDesmatada extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseAreaDesmatada(this._atividade);

  @override
  AreaDesmatada createState() => AreaDesmatada();
}

class AreaDesmatada extends State<ClasseAreaDesmatada> {
  TextEditingController _tecDescricao = new TextEditingController();
  FocusNode _fnDescricao;
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
                        controller: _tecDescricao,
                        focusNode: _fnDescricao,
                        maxLength: 150,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: 'Como está o desmatamento na área?*',
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
                                if (validaCampos()) {
                                  widget._atividade.adicionaResposta(CaracteristicaAreaDesmatada(_imageFile, _tecDescricao.text));
                                  Navigator.pop(context);
                                }
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
                                Navigator.pop(context);
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

  bool validaCampos() {
    if (_tecDescricao.text.isEmpty) {
      _fnDescricao.requestFocus();
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    dynamic foto = widget._atividade.respostaAtividade;

    if (foto != null) {
      _tecDescricao.text = foto.getDescricao();
      _imageFile = foto.getImageFile();
    }

    _fnDescricao = FocusNode();
  }

  @override
  void dispose() {
    _fnDescricao.dispose();
    super.dispose();
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
