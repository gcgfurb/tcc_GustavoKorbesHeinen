import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaFichaDeColeta.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:image_picker/image_picker.dart';

class ClasseFichaDeColeta_2 extends StatefulWidget {
  Atividade _atividade = new Atividade();
  CaracteristicaFichaDeColeta _fichaDeColeta;
  ClasseFichaDeColeta_2(this._atividade, this._fichaDeColeta);

  @override
  FichaDeColeta_2 createState() => FichaDeColeta_2();
}

class FichaDeColeta_2 extends State<ClasseFichaDeColeta_2> {
  TextEditingController _tecConservacao = new TextEditingController();
  TextEditingController _tecObservacoes = new TextEditingController();
  PickedFile _imageFile;

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
                children: <Widget>[
                  _decideImageView(),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: 150,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        _openCamera(context);
                      },
                      heroTag: 'video1',
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 5),
                    child: TextField(
                      controller: _tecConservacao,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'De que forma será conservado?', hintText: 'meio líquido, vidro, vácuo'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 20, 10),
                      child: TextField(
                        maxLines: 5,
                        maxLength: 150,
                        controller: _tecObservacoes,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Quais são as suas observações?',
                          hintText: 'Descrever o estado do organismo ou informações relevantes',
                          alignLabelWithHint: true,
                        ),
                      ),
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
                              widget._atividade.adicionaResposta(CaracteristicaFichaDeColeta(
                                  widget._fichaDeColeta.getNomePessoa(),
                                  widget._fichaDeColeta.getLocal(),
                                  widget._fichaDeColeta.getData(),
                                  widget._fichaDeColeta.getHora(),
                                  widget._fichaDeColeta.getAmbiente(),
                                  widget._fichaDeColeta.getNomePopularCientifico(),
                                  _tecConservacao.text,
                                  _tecObservacoes.text,
                                  _imageFile));
                              Navigator.pop(context);
                              Navigator.pop(context);
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
                            child: Text("Voltar"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      color: Colors.red[500],
                      textColor: Colors.white,
                      child: Text("Cancelar"),
                      onPressed: () {
                        Navigator.pop(context);
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
    );
  }

  @override
  void initState() {
    super.initState();
    dynamic fichaDeColeta = widget._atividade.getRespostaAtividade();

    if (fichaDeColeta != null) {
      _tecConservacao.text = fichaDeColeta.getConservacao();
      _tecObservacoes.text = fichaDeColeta.getObservacoes();
      _imageFile = fichaDeColeta.getImageFile();
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
      ));
    }
  }
}
