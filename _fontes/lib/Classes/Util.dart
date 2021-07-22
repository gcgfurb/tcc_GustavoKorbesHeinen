import 'dart:convert';
import 'dart:io';
import 'package:googleapis/drive/v3.dart' as v3;
import 'Constantes.dart' as Constantes;

import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaAreaDesmatada.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaFichaDeColeta.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaFoto.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaIntervencao.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaLixo.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaProducaoDeMaterial.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaSonsDaNatureza.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaVivencia.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Personalizada.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/AreaDesmatada.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Audio.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Caracteristica.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Desenho.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/FichaDeColeta_1.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Foto.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Interacao.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Intervencao.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Lixo.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Localizacao.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Lupa.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Medida.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Mosquito.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Planta.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/ProducaoDeMaterial.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Solo.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/SonsDaNatureza.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Teste.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Video.dart';
import 'package:TCC_II/Telas/Telas_Caracteristicas/Vivencia.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GoogleAuthClient.dart';
import 'Caracteristicas/CaracteristicaAudio.dart';
import 'Caracteristicas/CaracteristicaCaracteristica.dart';
import 'Caracteristicas/CaracteristicaDesenho.dart';
import 'Caracteristicas/CaracteristicaInteracao.dart';
import 'Caracteristicas/CaracteristicaLocalizacao.dart';
import 'Caracteristicas/CaracteristicaLupa.dart';
import 'Caracteristicas/CaracteristicaMedida.dart';
import 'Caracteristicas/CaracteristicaMosquito.dart';
import 'Caracteristicas/CaracteristicaPersonalizada.dart';
import 'Caracteristicas/CaracteristicaPlanta.dart';
import 'Caracteristicas/CaracteristicaSolo.dart';
import 'Caracteristicas/CaracteristicaTeste.dart';
import 'Caracteristicas/CaracteristicaVideo.dart';
import 'Roteiro.dart';

class Util {
  static GoogleSignInAccount account;

  static Map<String, String> _authHeaders;
  static GoogleAuthClient _authenticateClient;
  static v3.DriveApi _driveApi;

  static int stringToId(String caracteristica) {
    if (caracteristica == "Foto")
      return 0;
    else if (caracteristica == "Medida")
      return 1;
    else if (caracteristica == "Solo")
      return 2;
    else if (caracteristica == "Interação")
      return 3;
    else if (caracteristica == "Área desmatada")
      return 4;
    else if (caracteristica == "Vídeo")
      return 5;
    else if (caracteristica == "Característica")
      return 6;
    else if (caracteristica == "Lupa")
      return 7;
    else if (caracteristica == "Vivência")
      return 8;
    else if (caracteristica == "Mosquito")
      return 9;
    else if (caracteristica == "Áudio")
      return 10;
    else if (caracteristica == "Teste")
      return 11;
    else if (caracteristica == "Desenhar")
      return 12;
    else if (caracteristica == "Ficha Coleta")
      return 13;
    else if (caracteristica == "Lixo")
      return 14;
    else if (caracteristica == "Sons da Natureza")
      return 15;
    else if (caracteristica == "Localização")
      return 16;
    else if (caracteristica == "Produção de Material")
      return 17;
    else if (caracteristica == "Outra intervenção")
      return 18;
    else if (caracteristica == "Plantar")
      return 19;
    else
      return -1;
  }

  static Future<void> escolheAtividadeCorreta(BuildContext context, Atividade atividade) async {
    switch (atividade.getId()) {
      case 0:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseFoto(atividade)));
        break;
      case 1:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseMedida(atividade)));
        break;
      case 2:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseSolo(atividade)));
        break;
      case 3:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseInteracao(atividade)));
        break;
      case 4:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAreaDesmatada(atividade)));
        break;
      case 5:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVideo(atividade)));
        break;
      case 6:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCaracteristica(atividade)));
        break;
      case 7:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseLupa(atividade)));
        break;
      case 8:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVivencia(atividade)));
        break;
      case 9:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseMosquito(atividade)));
        break;
      case 10:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAudio(atividade)));
        break;
      case 11:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseTeste(atividade)));
        break;
      case 12:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseDesenho(atividade)));
        break;
      case 13:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseFichaDeColeta_1(atividade)));
        break;
      case 14:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseLixo(atividade)));
        break;
      case 15:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseSonsDaNatureza(atividade)));
        break;
      case 16:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseLocalizacao(atividade)));
        break;
      case 17:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseProducaoDeMaterial(atividade)));
        break;
      case 18:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseIntervencao(atividade)));
        break;
      case 19:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassePlanta(atividade)));
        break;
      default:
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassePersonalizada(atividade)));
        break;
    }
  }

  static Future<void> abreGoogleMaps(String geolocator) async {
    String lat;
    String long;
    List<String> coordenadas = geolocator.split(',');
    lat = coordenadas[0].substring(coordenadas[0].indexOf(':') + 1, coordenadas[0].length);
    long = coordenadas[1].substring(coordenadas[1].indexOf(':') + 1, coordenadas[1].length);
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Não conseguiu acessar o Google Maps.';
    }
  }

  static List<int> leTema(Tema tema) {
    List<int> values = utf8.encode('Tema: ' + tema.getTema() + '\n');
    values += utf8.encode('Descricao: ' + tema.getDescricao());

    return values;
  }

  static List<int> leObjEspecifico(ObjEspecifico objEspecifico) {
    return utf8.encode('Objetivo: ' + objEspecifico.getObjetivo());
  }

  static List<int> leRoteiro(Roteiro roteiro) {
    return utf8.encode('Ordenado: ' + (roteiro.getOrdenado() ? "Sim" : "Não"));
  }

  static List<int> leAtividade(Atividade atividade, v3.File folder) {
    List<int> values = utf8.encode('Atividade: ' + atividade.getNomeAtividade() + '\n');
    values += utf8.encode('Descricao: ' + atividade.getDescricao() + '\n');
    values += adicionaResposta(atividade, folder);

    return values;
  }

  static List<int> adicionaResposta(Atividade atividade, v3.File folder) {
    List<int> values;

    switch (atividade.getId()) {
      case 0:
        CaracteristicaFoto foto = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + foto.getDescricao() + '\n');
        gravaMidiaAtividade(foto.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 1:
        CaracteristicaMedida medida = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta dimensão 1: ' + medida.getDimensao1().toString() + '\n');
        values += utf8.encode('Resposta un. Med. 1: ' + medida.getUnMed1().toString() + '\n');
        values += utf8.encode('Resposta valor 1: ' + medida.getValor1().toString() + '\n');

        values += utf8.encode('Resposta dimensão 2: ' + medida.getDimensao2().toString() + '\n');
        values += utf8.encode('Resposta un. Med. 2: ' + medida.getUnMed2().toString() + '\n');
        values += utf8.encode('Resposta valor 2: ' + medida.getValor2().toString() + '\n');

        values += utf8.encode('Resposta cálculo: ' + medida.getCalculo().toString());

        return values;

      case 2:
        CaracteristicaSolo solo = atividade.getRespostaAtividade();
        values = utf8.encode('Coloração Solo: ' + solo.getResposta1() + '\n');
        values += utf8.encode('Matéria Orgânica: ' + solo.getResposta2() + '\n');
        values += utf8.encode('Granulometria: ' + solo.getResposta3() + '\n');
        values += utf8.encode('Elementos Químicos: ' + solo.getResposta4());

        return values;

      case 3:
        CaracteristicaInteracao interacao = atividade.getRespostaAtividade();
        values = utf8.encode('Seres vivos interagindo: ' + interacao.getResposta1() + '\n');
        values += utf8.encode('Interação: ' + interacao.getResposta2());

        return values;

      case 4:
        CaracteristicaAreaDesmatada areaDesmatada = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + areaDesmatada.getDescricao() + '\n');
        values += utf8.encode('Resposta coordenada: ' + areaDesmatada.getCoordenada() + '\n');
        gravaMidiaAtividade(areaDesmatada.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 5:
        CaracteristicaVideo video = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + video.getDescricao() + '\n');

        String path = video.getVideoFile().dataSource.substring(8, video.getVideoFile().dataSource.length);
        gravaMidiaAtividade(path, folder, Constantes.VIDEO_ATIVIDADE);

        return values;

      case 6:
        CaracteristicaCaracteristica caracteristica = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta: ' + caracteristica.getResposta());

        return values;

      case 7:
        CaracteristicaLupa lupa = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + lupa.getDescricao() + '\n');
        gravaMidiaAtividade(lupa.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 8:
        CaracteristicaVivencia vivencia = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta: ' + vivencia.getResposta());

        return values;

      case 9:
        CaracteristicaMosquito mosquito = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + mosquito.getDescricao() + '\n');
        values += utf8.encode('Resposta coordenada: ' + mosquito.getCoordenada() + '\n');
        gravaMidiaAtividade(mosquito.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 10:
        CaracteristicaAudio audio = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + audio.getDescricao() + '\n');
        gravaMidiaAtividade(audio.getPath(), folder, Constantes.AUDIO_ATIVIDADE);

        return values;

      case 11:
        CaracteristicaTeste teste = atividade.getRespostaAtividade();
        values = utf8.encode('Teste realizado: ' + teste.getResposta1().toString() + '\n');
        values += utf8.encode('Valor: ' + teste.getResposta2().toString());

        return values;

      case 12:
        CaracteristicaDesenho desenho = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta desenho: ' + desenho.toString());

        return values;

      case 13:
        CaracteristicaFichaDeColeta fichaDeColeta = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta nome: ' + fichaDeColeta.getNomePessoa() + '\n');
        values += utf8.encode('Resposta local: ' + fichaDeColeta.getLocal() + '\n');
        values += utf8.encode('Resposta data: ' + fichaDeColeta.getData() + '\n');
        values += utf8.encode('Resposta hora: ' + fichaDeColeta.getHora() + '\n');
        values += utf8.encode('Resposta ambiente: ' + fichaDeColeta.getAmbiente() + '\n');
        values += utf8.encode('Resposta nome Popular ou Científico: ' + fichaDeColeta.getNomePopularCientifico() + '\n');

        values += utf8.encode('Resposta conservacão: ' + fichaDeColeta.getConservacao() + '\n');
        values += utf8.encode('Resposta observações: ' + fichaDeColeta.getObservacoes() + '\n');

        gravaMidiaAtividade(fichaDeColeta.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 14:
        CaracteristicaLixo lixo = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + lixo.getDescricao() + '\n');
        values += utf8.encode('Resposta coordenada: ' + lixo.getCoordenada() + '\n');
        gravaMidiaAtividade(lixo.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 15:
        CaracteristicaSonsDaNatureza sonsDaNatureza = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + sonsDaNatureza.getDescricao() + '\n');
        gravaMidiaAtividade(sonsDaNatureza.getPath(), folder, Constantes.AUDIO_ATIVIDADE);

        return values;

      case 16:
        CaracteristicaLocalizacao localizacao = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta localização: Latitude: ' + localizacao.getCoordenada().latitude.toString() + ', Longitude: ' + localizacao.getCoordenada().longitude.toString());

        return values;

      case 17:
        CaracteristicaProducaoDeMaterial producaoDeMaterial = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + producaoDeMaterial.getDescricao() + '\n');
        gravaMidiaAtividade(producaoDeMaterial.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 18:
        CaracteristicaIntervencao intervencao = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta descrição: ' + intervencao.getDescricao() + '\n');
        values += utf8.encode('Resposta coordenada: ' + intervencao.getCoordenada() + '\n');
        gravaMidiaAtividade(intervencao.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      case 19:
        CaracteristicaPlanta planta = atividade.getRespostaAtividade();
        values = utf8.encode('Resposta nome popular: ' + planta.getNomePopular() + '\n');
        values += utf8.encode('Resposta nome científico: ' + planta.getNomeCientifico() + '\n');
        gravaMidiaAtividade(planta.getImageFile().path, folder, Constantes.IMAGEM_ATIVIDADE);

        return values;

      default:
        CaracteristicaPersonalizada personalizada = atividade.getRespostaAtividade();
        values = utf8.encode('Pergunta: ' + personalizada.getPergunta() + '\n');
        values += utf8.encode('Resposta: ' + personalizada.getResposta());

        return values;
    }
  }

  static void gravaMidiaAtividade(String path, v3.File folder, nomeArquivo) async {
    List<int> bytes = File(path).readAsBytesSync();
    final Stream<List<int>> mediaStream = Future.value(bytes).asStream().asBroadcastStream();
    var media = new v3.Media(mediaStream, bytes.length);

    var driveFile = new v3.File();
    driveFile.parents = [folder.id];
    driveFile.name = nomeArquivo;

    v3.DriveApi driveApi = await getDriveApi();

    await driveApi.files.create(driveFile, uploadMedia: media);
  }

  static Future<void> gravaDados(List<int> values, String nomeArquivo, v3.File folder) async {
    final Stream<List<int>> mediaStream = Future.value(values).asStream().asBroadcastStream();
    var media = new v3.Media(mediaStream, values.length);

    var driveFile = new v3.File();
    driveFile.parents = [folder.id];
    driveFile.name = nomeArquivo;

    v3.DriveApi driveApi = await getDriveApi();
    await driveApi.files.create(driveFile, uploadMedia: media);
  }

  static Future<v3.DriveApi> inicializaAutenticaoDrive(GoogleSignIn googleSignIn) async {
    account = await googleSignIn.signIn();
    return getDriveApi();
  }

  static Future<v3.DriveApi> getDriveApi() async {
    _authHeaders = await account.authHeaders;
    _authenticateClient = GoogleAuthClient(_authHeaders);
    _driveApi = v3.DriveApi(_authenticateClient);

    return _driveApi;
  }
}
