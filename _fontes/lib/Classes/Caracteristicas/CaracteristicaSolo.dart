import '../Resposta.dart';

class CaracteristicaSolo extends Resposta {
  String _resposta1;
  String _resposta2;
  String _resposta3;
  String _resposta4;

  CaracteristicaSolo(String resposta1, String resposta2, String resposta3, String resposta4) {
    _resposta1 = resposta1;
    _resposta2 = resposta2;
    _resposta3 = resposta3;
    _resposta4 = resposta4;
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

  String getResposta3() {
    return _resposta3;
  }

  void setResposta3(String resposta3) {
    _resposta3 = resposta3;
  }

  String getResposta4() {
    return _resposta4;
  }

  void setResposta4(String resposta4) {
    _resposta4 = resposta4;
  }
}
