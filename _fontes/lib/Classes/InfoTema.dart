class InfoTema {
  List<String> _info;

  InfoTema(List<String> info) {
    _info = info;
  }

  List<String> getInfo() {
    return _info;
  }

  String getInfoEspecifica(int index) {
    return _info[index];
  }
}
