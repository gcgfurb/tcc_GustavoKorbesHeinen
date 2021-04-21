import '../Resposta.dart';

class CaracteristicaCaracteristica extends Resposta {
  String _resposta;

  CaracteristicaCaracteristica(String resposta) {
    _resposta = resposta;
  }

  String getResposta() {
    return _resposta;
  }

  void setResposta(String resposta) {
    _resposta = resposta;
  }
}
