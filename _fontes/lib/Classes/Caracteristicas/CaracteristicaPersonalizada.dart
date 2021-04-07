import '../Resposta.dart';

class CaracteristicaPersonalizada extends Resposta {
  String _pergunta;
  String _resposta;

  CaracteristicaPersonalizada(String pergunta, String resposta) {
    _pergunta = pergunta;
    _resposta = resposta;
  }

  String getPergunta() {
    return _pergunta;
  }

  void setPergunta(String pergunta) {
    _pergunta = pergunta;
  }

  String getResposta() {
    return _resposta;
  }

  void setResposta(String resposta) {
    _resposta = resposta;
  }
}
