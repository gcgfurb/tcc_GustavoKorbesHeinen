import 'package:image_picker/image_picker.dart';
import '../Resposta.dart';

class CaracteristicaIntervencao extends Resposta {
  PickedFile _imageFile;
  String _descricao;
  String _coordenada;

  CaracteristicaIntervencao(PickedFile imageFile, String descricao, String coordenada) {
    _imageFile = imageFile;
    _descricao = descricao;
    _coordenada = coordenada;
  }

  PickedFile getImageFile() {
    return _imageFile;
  }

  void setImageFile(PickedFile imageFile) {
    _imageFile = imageFile;
  }

  String getDescricao() {
    return _descricao;
  }

  void setDescricao(String descricao) {
    _descricao = descricao;
  }

  String getCoordenada() {
    return _coordenada;
  }

  void setCoordenada(String coordenada) {
    _coordenada = coordenada;
  }
}
