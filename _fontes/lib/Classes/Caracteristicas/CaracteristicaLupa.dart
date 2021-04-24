import 'package:camera/camera.dart';
import '../Resposta.dart';

class CaracteristicaLupa extends Resposta {
  CameraController _imageFile;
  String _descricao;

  CaracteristicaLupa(CameraController imageFile, String descricao) {
    _imageFile = imageFile;
    _descricao = descricao;
  }

  CameraController getImageFile() {
    return _imageFile;
  }

  void setImageFile(CameraController imageFile) {
    _imageFile = imageFile;
  }

  String getDescricao() {
    return _descricao;
  }

  void setDescricao(String descricao) {
    _descricao = descricao;
  }
}
