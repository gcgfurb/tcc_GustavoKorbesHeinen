import 'package:audioplayers/audioplayers.dart';

import '../Resposta.dart';

class CaracteristicaSonsDaNatureza extends Resposta {
  AudioPlayer _audioPlayer;
  String _descricao;
  String _path;

  CaracteristicaSonsDaNatureza(AudioPlayer audioPlayer, String descricao, String path) {
    _audioPlayer = audioPlayer;
    _descricao = descricao;
    _path = path;
  }

  AudioPlayer getAudioPlayer() {
    return _audioPlayer;
  }

  void setAudioPlayer(AudioPlayer audioPlayer) {
    _audioPlayer = audioPlayer;
  }

  String getDescricao() {
    return _descricao;
  }

  void setDescricao(String descricao) {
    _descricao = descricao;
  }

  String getPath() {
    return _path;
  }

  void setPath(String path) {
    _path = path;
  }
}
