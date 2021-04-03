import '../Resposta.dart';

class CaracteristicaInteracao extends Resposta {
  String _resposta1;
  String _resposta2;

  CaracteristicaInteracao(String resposta1, String resposta2) {
    _resposta1 = resposta1;
    _resposta2 = resposta2;
  }

  String getResposta1() {
    return _resposta1;
  }

  void setResposta1(String resposta1) {
    _resposta1 = resposta1;
  }

  String getResposta2() {
    return _resposta2;
  }

  void setResposta2(String resposta2) {
    _resposta2 = resposta2;
  }
}
