import 'Caracteristicas/CaracteristicaAreaDesmatada.dart';
import 'Caracteristicas/CaracteristicaCaracteristica.dart';
import 'Caracteristicas/CaracteristicaDesenho.dart';
import 'Caracteristicas/CaracteristicaFichaDeColeta.dart';
import 'Caracteristicas/CaracteristicaLixo.dart';
import 'Caracteristicas/CaracteristicaLocalizacao.dart';
import 'Caracteristicas/CaracteristicaLupa.dart';
import 'Caracteristicas/CaracteristicaMosquito.dart';
import 'Caracteristicas/CaracteristicaPersonalizada.dart';
import 'Caracteristicas/CaracteristicaInteracao.dart';
import 'Caracteristicas/CaracteristicaAudio.dart';
import 'Caracteristicas/CaracteristicaFoto.dart';
import 'Caracteristicas/CaracteristicaPlanta.dart';
import 'Caracteristicas/CaracteristicaProducaoDeMaterial.dart';
import 'Caracteristicas/CaracteristicaSolo.dart';
import 'Caracteristicas/CaracteristicaMedida.dart';
import 'Caracteristicas/CaracteristicaSonsDaNatureza.dart';
import 'Caracteristicas/CaracteristicaTeste.dart';
import 'Caracteristicas/CaracteristicaVideo.dart';
import 'Caracteristicas/CaracteristicaVivencia.dart';
import 'Caracteristicas/CaracteristicaIntervencao.dart';
import 'Resposta.dart';

class Atividade {
  int _id;
  String _descricao;
  String _nomeAtividade;
  Resposta respostaAtividade;

  Atividade() {
    _nomeAtividade = "";
    _descricao = "";
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
        respostaAtividade = new CaracteristicaMedida(object.getDimensao1(), object.getUnMed1(), object.getValor1(), object.getDimensao2(), object.getUnMed2(), object.getValor2(), object.getCalculo());
        break;
      case 2:
        respostaAtividade = new CaracteristicaSolo(object.getResposta1(), object.getResposta2(), object.getResposta3(), object.getResposta4());
        break;
      case 3:
        respostaAtividade = new CaracteristicaInteracao(object.getResposta1(), object.getResposta2());
        break;
      case 4:
        respostaAtividade = new CaracteristicaAreaDesmatada(object.getImageFile(), object.getDescricao());
        break;
      case 5:
        respostaAtividade = new CaracteristicaVideo(object.getVideoFile(), object.getDescricao());
        break;
      case 6:
        respostaAtividade = new CaracteristicaCaracteristica(object.getResposta());
        break;
      case 7:
        respostaAtividade = new CaracteristicaLupa(object.getImageFile(), object.getDescricao());
        break;
      case 8:
        respostaAtividade = new CaracteristicaVivencia(object.getResposta());
        break;
      case 9:
        respostaAtividade = new CaracteristicaMosquito(object.getImageFile(), object.getDescricao());
        break;
      case 10:
        respostaAtividade = new CaracteristicaAudio(object.getDescricao());
        break;
      case 11:
        respostaAtividade = new CaracteristicaTeste(object.getResposta1(), object.getResposta2());
        break;
      case 12:
        respostaAtividade = new CaracteristicaDesenho();
        break;
      case 13:
        respostaAtividade = new CaracteristicaFichaDeColeta(object.getNomePessoa(), object.getLocal(), object.getData(), object.getHora(), object.getAmbiente(), object.getNomePopularCientifico(),
            object.getConservacao(), object.getObservacoes(), object.getImageFile());
        break;
      case 14:
        respostaAtividade = new CaracteristicaLixo(object.getImageFile(), object.getDescricao());
        break;
      case 15:
        respostaAtividade = new CaracteristicaSonsDaNatureza();
        break;
      case 16:
        respostaAtividade = new CaracteristicaLocalizacao();
        break;
      case 17:
        respostaAtividade = new CaracteristicaProducaoDeMaterial(object.getImageFile(), object.getDescricao());
        break;
      case 18:
        respostaAtividade = new CaracteristicaIntervencao(object.getImageFile(), object.getDescricao());
        break;
      case 19:
        respostaAtividade = new CaracteristicaPlanta(object.getImageFile(), object.getNomePopular(), object.getNomeCientifico());
        break;
      default:
        respostaAtividade = new CaracteristicaPersonalizada(object.getPergunta(), object.getResposta());
    }
  }
}
