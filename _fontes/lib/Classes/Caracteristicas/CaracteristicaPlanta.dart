import 'package:image_picker/image_picker.dart';

import '../Resposta.dart';

class CaracteristicaPlanta extends Resposta {
  PickedFile _imageFile;
  String _nomePopular;
  String _nomeCientifico;

  CaracteristicaPlanta(PickedFile imageFile, String nomePopular, String nomeCientifico) {
    _imageFile = imageFile;
    _nomePopular = nomePopular;
    _nomeCientifico = nomeCientifico;
  }

  PickedFile getImageFile() {
    return _imageFile;
  }

  void setImageFile(PickedFile imageFile) {
    _imageFile = imageFile;
  }

  String getNomePopular() {
    return _nomePopular;
  }

  void setNomePopular(String nomePopular) {
    _nomePopular = nomePopular;
  }

  String getNomeCientifico() {
    return _nomeCientifico;
  }

  void setNomeCientifico(String nomeCientifico) {
    _nomeCientifico = nomeCientifico;
  }
}
