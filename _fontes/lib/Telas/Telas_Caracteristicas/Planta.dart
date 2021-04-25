import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaPlanta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:image_picker/image_picker.dart';

class ClassePlanta extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClassePlanta(this._atividade);

  @override
  Planta createState() => Planta();
}

class Planta extends State<ClassePlanta> {
  TextEditingController _tecNomePopular = new TextEditingController();
  TextEditingController _tecNomeCientifico = new TextEditingController();
  FocusNode _fnNomePopular;
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
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 5),
                      child: TextField(
                        controller: _tecNomePopular,
                        focusNode: _fnNomePopular,
                        decoration: InputDecoration(
                          hintText: 'Qual o nome popular da planta?*',
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
                      padding: EdgeInsets.fromLTRB(0, 5, 20, 20),
                      child: TextField(
                        controller: _tecNomeCientifico,
                        decoration: InputDecoration(
                          hintText: 'Qual o nome científico da planta?',
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
                      padding: EdgeInsets.only(right: 20),
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
                                  widget._atividade.adicionaResposta(CaracteristicaPlanta(_imageFile, _tecNomePopular.text, _tecNomeCientifico.text));
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20),
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
    if (_tecNomePopular.text.isEmpty) {
      _fnNomePopular.requestFocus();
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    dynamic planta = widget._atividade.respostaAtividade;

    if (planta != null) {
      _tecNomePopular.text = planta.getNomePopular();
      _tecNomeCientifico.text = planta.getNomeCientifico();
      _imageFile = planta.getImageFile();
    }

    _fnNomePopular = FocusNode();
  }

  @override
  void dispose() {
    _fnNomePopular.dispose();
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
