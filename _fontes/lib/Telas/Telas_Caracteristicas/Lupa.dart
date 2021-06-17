import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaLupa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:image_picker/image_picker.dart';

class ClasseLupa extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseLupa(this._atividade);

  @override
  Lupa createState() => Lupa();
}

class Lupa extends State<ClasseLupa> {
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
                    Container(
                      child: TextField(
                        controller: _tecDescricao,
                        focusNode: _fnDescricao,
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
                                if (validaCampos()) {
                                  widget._atividade.adicionaResposta(CaracteristicaLupa(_imageFile, _tecDescricao.text));
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

    if (_imageFile == null) {
      showDialog(
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

      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    dynamic lupa = widget._atividade.getRespostaAtividade();

    if (lupa != null) {
      _tecDescricao.text = lupa.getDescricao();
      _imageFile = lupa.getImageFile();
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
