import 'package:image_picker/image_picker.dart';
import '../Resposta.dart';

class CaracteristicaMosquito extends Resposta {
  PickedFile _imageFile;
  String _descricao;

  CaracteristicaMosquito(PickedFile imageFile, String descricao) {
    _imageFile = imageFile;
    _descricao = descricao;
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
}
