import 'Imagem.dart';

class Atividade {
  String _atvidade;
  String _descricao;
  Imagem _imagem;
  String _resposta;

  Atividade(String atividade, String descricao) {
    _atvidade = atividade;
    _descricao = descricao;
  }

  void setAtividade(String atividade) {
    _atvidade = atividade;
  }

  String getAtividade() {
    return _atvidade;
  }

  void setDescricao(String descricao) {
    _descricao = descricao;
  }

  String getDescricao() {
    return _descricao;
  }

  void setResposta(String resposta) {
    _resposta = resposta;
  }

  String getResposta() {
    return _resposta;
  }
}
