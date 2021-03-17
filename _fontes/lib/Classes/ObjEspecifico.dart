import 'package:TCC_II/Classes/Roteiro.dart';

class ObjEspecifico {
  String _objetivo;
  Roteiro _roteiro;

  ObjEspecifico() {
    _objetivo = '';
    _roteiro = new Roteiro();
  }

  Roteiro getRoteiro() {
    return _roteiro;
  }

  void setRoteiro(Roteiro roteiro) {
    _roteiro = roteiro;
  }

  void setObjetivo(String sObjetivo) {
    _objetivo = sObjetivo;
  }

  String getObjetivo() {
    return _objetivo;
  }
}
