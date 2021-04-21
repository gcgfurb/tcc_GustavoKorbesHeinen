import 'package:video_player/video_player.dart';

import '../Resposta.dart';

class CaracteristicaVideo extends Resposta {
  VideoPlayerController _videoFile;
  String _descricao;

  CaracteristicaVideo(VideoPlayerController videoFile, String descricao) {
    _videoFile = videoFile;
    _descricao = descricao;
  }

  VideoPlayerController getImageFile() {
    return _videoFile;
  }

  void setImageFile(VideoPlayerController videoFile) {
    _videoFile = videoFile;
  }

  String getDescricao() {
    return _descricao;
  }

  void setDescricao(String descricao) {
    _descricao = descricao;
  }
}
