import 'Atividade.dart';

class Roteiro {
  List<Atividade> _atividades;
  bool _ordenado;

  Roteiro() {
    _atividades = [];
    _ordenado = false;
  }

  void adicionaAtividade(Atividade atividade) {
    _atividades.add(atividade);
  }

  void removeAtividade(int index) {
    _atividades.removeAt(index);
  }

  int getQtdAtividades() {
    return _atividades.length;
  }

  List<Atividade> getListaAtividade() {
    return _atividades;
  }

  Atividade getAtividade(int iPosicao) {
    return _atividades[iPosicao];
  }

  void setOrdenado(bool bOrdenado) {
    _ordenado = bOrdenado;
  }

  bool getOrdenado() {
    return _ordenado;
  }
}
