class Pessoa {
  int _id;
  String _nome;

  Pessoa(int id, String nome) {
    _id = id;
    _nome = nome;
  }

  int getID() {
    return _id;
  }

  void setID(int id) {
    _id = id;
  }

  String getNome() {
    return _nome;
  }

  void setNome(String nome) {
    _nome = nome;
  }
}
