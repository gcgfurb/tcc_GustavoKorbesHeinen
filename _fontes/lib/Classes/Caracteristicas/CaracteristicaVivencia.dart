import '../Resposta.dart';

class CaracteristicaVivencia extends Resposta {
  String _resposta;

  CaracteristicaVivencia(String resposta) {
    _resposta = resposta;
  }

  String getResposta() {
    return _resposta;
  }

  void setResposta(String resposta) {
    _resposta = resposta;
  }
}
