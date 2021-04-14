import 'ObjEspecifico.dart';

class Tema {
  List<ObjEspecifico> _objEspecificos;
  String _tema;
  String _descricao;
  bool _objDefinido;
  bool _roteiroDefinido;

  Tema() {
    _tema = '';
    _descricao = '';
    _objEspecificos = [];
    _objDefinido = false;
    _roteiroDefinido = false;
  }

  void adicionaObjEspecifico(ObjEspecifico objEspecifico) {
    _objEspecificos.add(objEspecifico);
  }

  void removeObjEspecifico(int index) {
    _objEspecificos.removeAt(index);
  }

  List<ObjEspecifico> getListaObjEspecifico() {
    return _objEspecificos;
  }

  ObjEspecifico getObjEspecifico(int iPosicao) {
    return _objEspecificos[iPosicao];
  }

  void setTema(String sTema) {
    _tema = sTema;
  }

  String getTema() {
    return _tema;
  }

  void setDescricao(String sDescricao) {
    _descricao = sDescricao;
  }

  String getDescricao() {
    return _descricao;
  }

  void setObjDefinido(bool objDefinido) {
    _objDefinido = objDefinido;
  }

  bool getObjDefinido() {
    return _objDefinido;
  }

  void setRoteiroDefinido(bool roteiroDefinido) {
    _roteiroDefinido = roteiroDefinido;
  }

  bool getRoteiroDefinido() {
    return _roteiroDefinido;
  }
}
