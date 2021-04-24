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
  TextEditingController _textoDescricao = new TextEditingController();
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
                                if (_imageFile == null) {
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) => CupertinoAlertDialog(
                                      title: Text("Campo obrigatório"),
                                      content: Text("É obrigatório adicionar uma imagem."),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          child: Text("OK"),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                //widget._atividade.adicionaResposta(CaracteristicaLupa(_imageFile, _textoDescricao.text));
                                Navigator.pop(context);
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

  @override
  void initState() {
    super.initState();
    dynamic lupa = widget._atividade.respostaAtividade;

    if (lupa != null) {
      _textoDescricao.text = lupa.getDescricao();
      _imageFile = lupa.getImageFile();
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
          child: Text("Nenhuma imagem no momento"),
        ),
      );
    } else {
      return Expanded(
          child: Image.file(
        File(_imageFile.path),
        width: 300,
        height: 300,
      ));
    }
  }
}

chamaTelaVisualizaRoteiro(BuildContext context) {
  Navigator.pop(context);
}
