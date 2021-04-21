import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaFichaDeColeta.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

import 'FichaDeColeta_2.dart';

class ClasseFichaDeColeta_1 extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseFichaDeColeta_1(this._atividade);

  @override
  FichaDeColeta_1 createState() => FichaDeColeta_1();
}

class FichaDeColeta_1 extends State<ClasseFichaDeColeta_1> {
  TextEditingController _tecNomePessoa = new TextEditingController();
  TextEditingController _tecLocal = new TextEditingController();
  TextEditingController _tecData = new TextEditingController();
  TextEditingController _tecHora = new TextEditingController();
  TextEditingController _tecAmbiente = new TextEditingController();
  TextEditingController _tecNomePopularCientifico = new TextEditingController();

  FocusNode _fnNomePessoa;
  FocusNode _fnLocal;
  FocusNode _fnData;
  FocusNode _fnHora;
  FocusNode _fnAmbiente;
  FocusNode _fnNomePopularCientifico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
              child: Text("Faça a ficha de coleta:"),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(widget._atividade.getDescricao()),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    child: TextField(
                      controller: _tecNomePessoa,
                      focusNode: _fnNomePessoa,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual o nome da pessoa que coletou?*'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 20, 5),
                    child: TextField(
                      controller: _tecLocal,
                      focusNode: _fnLocal,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual o local/cidade em que foi coletado?*'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    child: TextField(
                      controller: _tecData,
                      focusNode: _fnData,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual a data da coleta?*'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 20, 5),
                    child: TextField(
                      controller: _tecHora,
                      focusNode: _fnHora,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Qual a hora da coleta?*'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 10),
                    child: TextField(
                      controller: _tecAmbiente,
                      focusNode: _fnAmbiente,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Em que ambiente foi encontrado?*', hintText: 'Aquático, Terrestre'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 20, 10),
                    child: TextField(
                      controller: _tecNomePopularCientifico,
                      focusNode: _fnNomePopularCientifico,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Você sabe o nome popular ou científico?*'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 25, 30, 0),
                  child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text("Continuar"),
                      onPressed: () async {
                        if (validaCampos()) {
                          CaracteristicaFichaDeColeta fichaDeColeta =
                              new CaracteristicaFichaDeColeta(_tecNomePessoa.text, _tecLocal.text, _tecData.text, _tecHora.text, _tecAmbiente.text, _tecNomePopularCientifico.text, "", "", null);
                          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseFichaDeColeta_2(widget._atividade, fichaDeColeta)));
                        }
                      }),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                  child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text("Cancelar"),
                      onPressed: () {
                        return Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validaCampos() {
    if (_tecNomePessoa.text.isEmpty) {
      _fnNomePessoa.requestFocus();
      return false;
    }

    if (_tecLocal.text.isEmpty) {
      _fnLocal.requestFocus();
      return false;
    }

    if (_tecData.text.isEmpty) {
      _fnData.requestFocus();
      return false;
    }

    if (_tecHora.text.isEmpty) {
      _fnHora.requestFocus();
      return false;
    }

    if (_tecAmbiente.text.isEmpty) {
      _fnAmbiente.requestFocus();
      return false;
    }

    if (_tecNomePopularCientifico.text.isEmpty) {
      _fnNomePopularCientifico.requestFocus();
      return false;
    }

    return true;
  }

  void initState() {
    super.initState();
    dynamic fichaColeta = widget._atividade.respostaAtividade;

    if (fichaColeta != null) {
      _tecNomePessoa.text = fichaColeta.getNomePessoa();
      _tecLocal.text = fichaColeta.getLocal();
      _tecData.text = fichaColeta.getData();
      _tecHora.text = fichaColeta.getHora();
      _tecAmbiente.text = fichaColeta.getAmbiente();
      _tecNomePopularCientifico.text = fichaColeta.getNomePopularCientifico();
    }

    _fnNomePessoa = FocusNode();
    _fnLocal = FocusNode();
    _fnData = FocusNode();
    _fnHora = FocusNode();
    _fnAmbiente = FocusNode();
    _fnNomePopularCientifico = FocusNode();
  }

  @override
  void dispose() {
    _fnNomePessoa.dispose();
    _fnLocal.dispose();
    _fnData.dispose();
    _fnHora.dispose();
    _fnAmbiente.dispose();
    _fnNomePopularCientifico.dispose();
    super.dispose();
  }
}
