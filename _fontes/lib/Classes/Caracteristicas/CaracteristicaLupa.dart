import 'package:image_picker/image_picker.dart';
import '../Resposta.dart';

class CaracteristicaLupa extends Resposta {
  PickedFile _imageFile;
  String _descricao;

  CaracteristicaLupa(PickedFile imageFile, String descricao) {
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
