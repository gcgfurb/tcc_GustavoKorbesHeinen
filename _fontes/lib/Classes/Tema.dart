import 'ObjEspecifico.dart';

class Tema {
  List<ObjEspecifico> _objEspecificos;
  String _tema;
  String _descricao;

  Tema() {
    _tema = '';
    _descricao = '';
    _objEspecificos = new List();
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
}
