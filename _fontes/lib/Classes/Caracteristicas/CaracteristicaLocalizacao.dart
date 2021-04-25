import 'package:geolocator/geolocator.dart';

import '../Resposta.dart';

class CaracteristicaLocalizacao extends Resposta {
  Position _position;

  CaracteristicaLocalizacao(Position position) {
    _position = position;
  }

  Position getCoordenada() {
    return _position;
  }

  void setCoordenada(Position position) {
    _position = position;
  }
}
