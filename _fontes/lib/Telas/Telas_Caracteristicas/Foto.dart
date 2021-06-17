import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaFoto.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController _tecDescricao = new TextEditingController();
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
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: _tecDescricao,
                        maxLength: 150,
                        maxLines: 5,
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
                                FocusManager.instance.primaryFocus.unfocus();
                                if (_imageFile == null) {
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) => CupertinoAlertDialog(
                                      title: Text("Campo obrigatório"),
                                      content: Text("É obrigatório adicionar uma imagem."),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: Text("OK"),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                widget._atividade.adicionaResposta(CaracteristicaFoto(_imageFile, _tecDescricao.text));
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

  @override
  void initState() {
    super.initState();
    dynamic foto = widget._atividade.getRespostaAtividade();

    if (foto != null) {
      _tecDescricao.text = foto.getDescricao();
      _imageFile = foto.getImageFile();
    }
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
        ),
      );
    }
  }
}
