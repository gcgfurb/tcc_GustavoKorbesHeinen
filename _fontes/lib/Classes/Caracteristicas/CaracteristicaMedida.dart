import '../Resposta.dart';

class CaracteristicaMedida extends Resposta {
  int _dimensao1;
  int _dimensao2;
  int _unMed1;
  int _unMed2;
  int _valor1;
  int _valor2;
  String _calculo;

  CaracteristicaMedida(int dimensao1, int unMed1, int valor1, int dimensao2, int unMed2, int valor2, String calculo) {
    _dimensao1 = dimensao1;
    _dimensao2 = dimensao2;
    _unMed1 = unMed1;
    _unMed2 = unMed2;
    _valor1 = valor1;
    _valor2 = valor2;
    _calculo = calculo;
  }

  int getDimensao1() {
    return _dimensao1;
  }

  void setDimensao1(int dimensao) {
    _dimensao1 = dimensao;
  }

  int getDimensao2() {
    return _dimensao2;
  }

  void setDimensao2(int dimensao) {
    _dimensao2 = dimensao;
  }

  int getUnMed1() {
    return _unMed1;
  }

  void setUnMed1(int unMed) {
    _unMed1 = unMed;
  }

  int getUnMed2() {
    return _unMed2;
  }

  void setUnMed2(int unMed) {
    _unMed2 = unMed;
  }

  int getValor1() {
    return _valor1;
  }

  void setValor1(int valor) {
    _valor1 = valor;
  }

  int getValor2() {
    return _valor2;
  }

  void setValor2(int valor) {
    _valor1 = valor;
  }

  String getCalculo() {
    return _calculo;
  }

  void setCalculo(String calculo) {
    _calculo = calculo;
  }
}
