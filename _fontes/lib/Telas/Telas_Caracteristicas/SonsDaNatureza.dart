import 'dart:async';

import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaSonsDaNatureza.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class ClasseSonsDaNatureza extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseSonsDaNatureza(this._atividade);

  @override
  SonsDaNatureza createState() => SonsDaNatureza();
}

class SonsDaNatureza extends State<ClasseSonsDaNatureza> {
  bool showPlayer = false;
  String path;
  AudioPlayer audioPlayer = AudioPlayer();
  TextEditingController _tecDescricao = new TextEditingController();
  String pathAnterior = "";

  @override
  void initState() {
    super.initState();
    showPlayer = false;

    dynamic sonsDaNatureza = widget._atividade.getRespostaAtividade();

    if (sonsDaNatureza != null) {
      _tecDescricao.text = sonsDaNatureza.getDescricao();
      audioPlayer = sonsDaNatureza.getAudioPlayer();
      pathAnterior = sonsDaNatureza.getPath();
      showPlayer = true;
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
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Text(
                "Registre sons da natureza:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                widget._atividade.getDescricao(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            FutureBuilder<String>(
              future: getPath(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (showPlayer) {
                    return Padding(
                      padding: EdgeInsets.zero,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.play_arrow,
                          size: 50,
                        ),
                        onPressed: () {
                          if (pathAnterior.isNotEmpty) path = pathAnterior;
                          audioPlayer.play(path, isLocal: true);
                        },
                      ),
                    );
                  } else {
                    return Container(
                      child: AudioRecorder(
                        path: snapshot.data,
                        onStop: () {
                          setState(() => showPlayer = true);
                        },
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: TextField(
                controller: _tecDescricao,
                maxLength: 150,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Descreva um resumo do áudio',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      if (!validaCampos()) {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                            title: Text("Campo obrigatório"),
                            content: Text("É obrigatório adicionar um áudio."),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("OK"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      }
                      widget._atividade.adicionaResposta(CaracteristicaSonsDaNatureza(audioPlayer, _tecDescricao.text, path));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validaCampos() {
    if (showPlayer) return true;

    return false;
  }

  Future<String> getPath() async {
    if (path == null) {
      final dir = await getApplicationDocumentsDirectory();
      path = dir.path + '/' + DateTime.now().millisecondsSinceEpoch.toString() + '.m4a';
    }
    return path;
  }
}

class AudioRecorder extends StatefulWidget {
  final String path;
  final VoidCallback onStop;

  const AudioRecorder({this.path, this.onStop});

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer _timer;

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[300],
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildRecordStopControl(),
          const SizedBox(width: 20),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildRecordStopControl() {
    Icon icon;
    Color color;

    if (_isRecording || _isPaused) {
      icon = Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }

    return Text(
      "Aguardando áudio",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await Record.hasPermission()) {
        await Record.start(path: widget.path);

        bool isRecording = await Record.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    await Record.stop();

    setState(() => _isRecording = false);

    widget.onStop();
  }

  void _startTimer() {
    const tick = const Duration(seconds: 1);

    _timer?.cancel();

    _timer = Timer.periodic(tick, (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}
