import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaVideo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ClasseVideo extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseVideo(this._atividade);

  @override
  Video createState() => Video();
}

class Video extends State<ClasseVideo> {
  TextEditingController _textoDescricao = new TextEditingController();
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

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
            Column(
              children: <Widget>[
                _decideImageView(),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
              ],
            ),
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
                        child: Text("Alterar vídeo"),
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
                                if (_controller.dataSource == null) {
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) => CupertinoAlertDialog(
                                      title: Text("Campo obrigatório"),
                                      content: Text("É obrigatório adicionar um vídeo."),
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
                                widget._atividade.adicionaResposta(CaracteristicaVideo(_controller, _textoDescricao.text));
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
    dynamic video = widget._atividade.respostaAtividade;

    if (video != null) {
      _textoDescricao.text = video.getDescricao();
      _controller = video.getVideoFile();
    } else {
      _controller = VideoPlayerController.file(File(""));
    }

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _openCamera(BuildContext context) async {
    var video = await ImagePicker.platform.pickVideo(source: ImageSource.camera);
    if (video != null) {
      this.setState(() {
        _controller = VideoPlayerController.file(File(video.path));
      });
    }
  }

  Widget _decideImageView() {
    if (_controller.dataSource == null) {
      return Expanded(
        child: Center(
          child: Text("Nenhum vídeo no momento"),
        ),
      );
    } else {
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          height: 300,
          width: 300,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return VideoPlayer(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    }
  }
}
