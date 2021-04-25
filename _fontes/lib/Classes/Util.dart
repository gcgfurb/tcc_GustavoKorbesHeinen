import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Telas/Aluno/cadastrarNovaPergunta.dart';
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

class Util {
  static GoogleSignInAccount account;

  static String idToString(int index) {
    switch (index) {
      case 0:
        return "Foto";
      case 1:
        return "Medida";
      case 2:
        return "Solo";
      case 3:
        return "Interação";
      case 4:
        return "Área desmatada";
      case 5:
        return "Vídeo";
      case 6:
        return "Característica";
      case 7:
        return "Lupa";
      case 8:
        return "Vivência";
      case 9:
        return "Mosquito";
      case 10:
        return "Áudio";
      case 11:
        return "Teste";
      case 12:
        return "Desenhar";
      case 13:
        return "Ficha Coleta";
      case 14:
        return "Lixo";
      case 15:
        return "Sons da Natureza";
      case 16:
        return "Localização";
      case 17:
        return "Produção de Material";
      case 18:
        return "Outra intervenção";
      case 19:
        return "Plantar";
      default:
        return "";
    }
  }

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

  static void escolheAtividadeCorreta(BuildContext context, Atividade atividade) async {
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
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseNovaPergunta(atividade)));
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
}
