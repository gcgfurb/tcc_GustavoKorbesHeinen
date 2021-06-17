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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _decideImageView(),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      _openCamera(context);
                    },
                    heroTag: 'video1',
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IntrinsicWidth(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 15, 5),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 150,
                            child: ElevatedButton(
                              child: Text(
                                'Cancelar',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            width: 150,
                            child: ElevatedButton(
                              child: Text(
                                'Gravar',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                              ),
                              onPressed: () {
                                if (validaCampos()) {
                                  widget._atividade.adicionaResposta(CaracteristicaPlanta(_imageFile, _tecNomePopular.text, _tecNomeCientifico.text));
                                  Navigator.pop(context);
                                }
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

    dynamic planta = widget._atividade.getRespostaAtividade();

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
    var _picker = ImagePicker();
    var picture = await _picker.getImage(source: ImageSource.camera);
    this.setState(() {
      _imageFile = picture;
    });
  }

  Widget _decideImageView() {
    if (_imageFile == null) {
      return Expanded(
        child: Center(
          child: Text(
            "Nenhuma imagem no momento",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    } else {
      return Expanded(
          child: Image.file(
        File(_imageFile.path),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
      ));
    }
  }
}
