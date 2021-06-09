import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaAreaDesmatada.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:geolocator/geolocator.dart';
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
  String geolocator = "";

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
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: _tecDescricao,
                        focusNode: _fnDescricao,
                        maxLength: 150,
                        maxLines: 5,
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
                      width: 190,
                      child: FloatingActionButton.extended(
                        heroTag: "btPosicao",
                        label: Text(
                          "Posição atual",
                          style: TextStyle(fontSize: 20),
                        ),
                        icon: Icon(Icons.location_on),
                        backgroundColor: Colors.blue[500],
                        onPressed: () async {
                          geolocator = "Buscando informações...";
                          setState(() {});
                          await Geolocator.getCurrentPosition().then((value) => {geolocator = value.toString()});
                          setState(() {});
                        },
                      ),
                    ),
                    TextButton(
                      child: Text(
                        geolocator,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          Util.abreGoogleMaps(geolocator);
                        });
                      },
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 150,
                            child: FloatingActionButton.extended(
                              heroTag: "btCancelar",
                              label: Text(
                                "Cancelar",
                                style: TextStyle(fontSize: 20),
                              ),
                              backgroundColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            width: 150,
                            child: FloatingActionButton.extended(
                              heroTag: "btGravar",
                              label: Text(
                                "Gravar",
                                style: TextStyle(fontSize: 20),
                              ),
                              backgroundColor: Colors.green,
                              onPressed: () {
                                if (validaCampos()) {
                                  widget._atividade.adicionaResposta(CaracteristicaAreaDesmatada(_imageFile, _tecDescricao.text, geolocator));
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
    if (_tecDescricao.text.isEmpty) {
      _fnDescricao.requestFocus();
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    dynamic areaDesmatada = widget._atividade.getRespostaAtividade();

    if (areaDesmatada != null) {
      _tecDescricao.text = areaDesmatada.getDescricao();
      _imageFile = areaDesmatada.getImageFile();
      geolocator = areaDesmatada.getCoordenada();
    }

    _fnDescricao = FocusNode();
  }

  @override
  void dispose() {
    _fnDescricao.dispose();
    super.dispose();
  }

  _openCamera(BuildContext context) async {
    var ip = ImagePicker();
    var picture = await ip.getImage(source: ImageSource.camera);
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
