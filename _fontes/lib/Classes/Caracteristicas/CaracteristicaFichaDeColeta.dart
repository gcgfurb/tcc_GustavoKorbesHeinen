import 'package:image_picker/image_picker.dart';
import '../Resposta.dart';

class CaracteristicaFichaDeColeta extends Resposta {
  String _nomePessoa;
  String _local;
  String _data;
  String _hora;
  String _ambiente;
  String _nomePopularCientifico;
  String _conservacao;
  String _observacoes;
  PickedFile _imageFile;

  CaracteristicaFichaDeColeta(String nomePessoa, String local, String data, String hora, String ambiente, String nomePopularCientifico, String conservacao, String observacoes, PickedFile imageFile) {
    _nomePessoa = nomePessoa;
    _local = local;
    _data = data;
    _hora = hora;
    _ambiente = ambiente;
    _nomePopularCientifico = nomePopularCientifico;
    _conservacao = conservacao;
    _observacoes = observacoes;
    _imageFile = imageFile;
  }

  String getNomePessoa() {
    return _nomePessoa;
  }

  void setNomePessoa(String nomePessoa) {
    _nomePessoa = nomePessoa;
  }

  String getLocal() {
    return _local;
  }

  void setLocal(String local) {
    _local = local;
  }

  String getData() {
    return _data;
  }

  void setData(String data) {
    _data = data;
  }

  String getHora() {
    return _hora;
  }

  void setHora(String hora) {
    _hora = hora;
  }

  String getAmbiente() {
    return _ambiente;
  }

  void setAmbiente(String ambiente) {
    _ambiente = ambiente;
  }

  String getNomePopularCientifico() {
    return _nomePopularCientifico;
  }

  void setNomePopularCientifico(String nomePopularCientifico) {
    _nomePopularCientifico = nomePopularCientifico;
  }

  String getConservacao() {
    return _conservacao;
  }

  void setConservacao(String conservacao) {
    _conservacao = conservacao;
  }

  String getObservacoes() {
    return _observacoes;
  }

  void setObservacoes(String observacoes) {
    _observacoes = observacoes;
  }

  PickedFile getImageFile() {
    return _imageFile;
  }

  void setImageFile(PickedFile imageFile) {
    _imageFile = imageFile;
  }
}
