import '../Resposta.dart';

class CaracteristicaAudio extends Resposta {
  String _descricao;

  CaracteristicaAudio(String descricao) {
    _descricao = descricao;
  }

  String getDescricao() {
    return _descricao;
  }

  void setDescricao(String descricao) {
    _descricao = descricao;
  }
}
