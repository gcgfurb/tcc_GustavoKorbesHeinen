class Util {
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
}
