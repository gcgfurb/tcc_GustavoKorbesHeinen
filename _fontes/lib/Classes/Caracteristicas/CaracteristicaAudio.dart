import 'package:audioplayers/audioplayers.dart';

import '../Resposta.dart';

class CaracteristicaAudio extends Resposta {
  AudioPlayer _audioPlayer;
  String _descricao;

  CaracteristicaAudio(AudioPlayer audioPlayer, String descricao) {
    _audioPlayer = audioPlayer;
    _descricao = descricao;
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
}
