import 'Caracteristicas/CaracteristicaInteracao.dart';
import 'Caracteristicas/CaracteristicaAudio.dart';
import 'Caracteristicas/CaracteristicaFoto.dart';
import 'Caracteristicas/CaracteristicaSolo.dart';
import 'Resposta.dart';

class Atividade {
  int _id;
  String _descricao;
  String _nomeAtividade;
  Resposta respostaAtividade;

  Atividade() {
    _nomeAtividade = '';
    _descricao = '';
  }

  void setId(int id) {
    _id = id;
  }

  int getId() {
    return _id;
  }

  void setNomeAtividade(String nomeAtividade) {
    _nomeAtividade = nomeAtividade;
  }

  String getNomeAtividade() {
    return _nomeAtividade;
  }

  void setDescricao(String descricao) {
    _descricao = descricao;
  }

  String getDescricao() {
    return _descricao;
  }

  void adicionaResposta(var object) {
    switch (this._id) {
      case 0:
        respostaAtividade = new CaracteristicaFoto(object.getImageFile(), object.getDescricao());
        break;
      case 1:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 2:
        respostaAtividade = new CaracteristicaSolo(object.getResposta1(), object.getResposta2(), object.getResposta3(), object.getResposta4());
        break;
      case 3:
        respostaAtividade = new CaracteristicaInteracao(object.getResposta1(), object.getResposta2());
        break;
      case 4:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 5:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 6:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 7:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 8:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 9:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 10:
        respostaAtividade = new CaracteristicaAudio(object.getDescricao());
        break;
      case 11:
        // respostaAtividade = new CaracteristicaFoto();
        break;
      case 12:
        // respostaAtividade = new CaracteristicaFoto();
        break;
      case 13:
        // respostaAtividade = new CaracteristicaFoto();
        break;
      case 14:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 15:
        // respostaAtividade = new CaracteristicaFoto();
        break;
      case 16:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 17:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 18:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      case 19:
        //respostaAtividade = new CaracteristicaFoto();
        break;
      default:
        respostaAtividade = null;
    }
  }
}
