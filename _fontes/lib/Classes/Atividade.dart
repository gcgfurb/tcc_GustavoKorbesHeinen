import 'Imagem.dart';

class Atividade {
  int _id;
  String _descricao;
  String _nomeAtividade;
  String _resposta;
  Imagem _imagem;

  Atividade() {
    _nomeAtividade = '';
    _descricao = '';
    _resposta = '';
  }

  void setId(int id) {
    _id = id;
  }

  int getId() {
    return _id;
  }

  void setNomeAtividade(String nomeAtividade) {
    _nomeAtividade = nomeAtividade;
  }

  String getNomeAtividade() {
    return _nomeAtividade;
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
