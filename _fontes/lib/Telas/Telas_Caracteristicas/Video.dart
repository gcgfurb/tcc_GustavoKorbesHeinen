import 'dart:io';

import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaVideo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/foundation.dart';

class ClasseVideo extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseVideo(this._atividade);

  @override
  Video createState() => Video();
}

class Video extends State<ClasseVideo> {
  TextEditingController _tecDescricao = new TextEditingController();
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    dynamic video = widget._atividade.getRespostaAtividade();

    if (video != null) {
      _tecDescricao.text = video.getDescricao();
      _controller = video.getVideoFile();
      _controller.setVolume(1);
      _controller.play();
    }
  }

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
                  defaultTargetPlatform == TargetPlatform.android ? _android() : _ios(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.red,
                        onPressed: () {
                          _onVideoButtonPressed(ImageSource.camera);
                        },
                        heroTag: 'video1',
                        child: const Icon(Icons.videocam),
                      ),
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          if (_controller != null) {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          }
                        },
                        child: Icon(
                          _controller != null
                              ? _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow
                              : Icons.play_arrow,
                        ),
                      ),
                    ],
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
                                if (_controller == null) {
                                  return showDialog(
                                    context: context,
                                    builder: (BuildContext context) => CupertinoAlertDialog(
                                      title: Text("Campo obrigatório"),
                                      content: Text("É obrigatório adicionar um vídeo."),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: Text("OK"),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                widget._atividade.adicionaResposta(CaracteristicaVideo(_controller, _tecDescricao.text));
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

  Future<void> _playVideo(PickedFile file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      VideoPlayerController controller;
      controller = VideoPlayerController.file(File(file.path));
      _controller = controller;
      final double volume = 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  void _onVideoButtonPressed(ImageSource source) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    final PickedFile file = await _picker.getVideo(source: source);
    await _playVideo(file);
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _ios() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        "Faça um vídeo sobre a atividade",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      );
    }
    return Expanded(
      child: AspectRatioVideo(_controller),
    );
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        await _playVideo(response.file);
      } else {
        _retrieveDataError = response.exception.code;
      }
    }
  }

  Widget _android() {
    return FutureBuilder<void>(
      future: retrieveLostData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Expanded(
              child: Center(
                child: Text(
                  "Nenhum vídeo selecionado.",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          case ConnectionState.done:
            return _ios();
          default:
            if (snapshot.hasError) {
              return Text(
                'Erro ao buscar vídeo: ${snapshot.error}}',
                textAlign: TextAlign.center,
              );
            } else {
              return const Text(
                'Nenhum vídeo selecionado.',
                textAlign: TextAlign.center,
              );
            }
        }
      },
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.isInitialized) {
      initialized = controller.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          height: 300,
          width: 300,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
