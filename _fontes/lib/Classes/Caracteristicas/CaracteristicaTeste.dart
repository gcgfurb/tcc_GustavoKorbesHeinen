import '../Resposta.dart';

class CaracteristicaTeste extends Resposta {
  int _resposta1;
  int _resposta2;

  CaracteristicaTeste(int resposta1, int resposta2) {
    _resposta1 = resposta1;
    _resposta2 = resposta2;
  }

  int getResposta1() {
    return _resposta1;
  }

  void setResposta1(int resposta1) {
    _resposta1 = resposta1;
  }

  int getResposta2() {
    return _resposta2;
  }

  void setResposta2(int resposta2) {
    _resposta2 = resposta2;
  }
}
