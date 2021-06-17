import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaLocalizacao.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ClasseLocalizacao extends StatefulWidget {
  Atividade _atividade;
  ClasseLocalizacao(this._atividade);

  @override
  Localizacao createState() => Localizacao();
}

class Localizacao extends State<ClasseLocalizacao> {
  String geolocator = "";
  bool bLink = false;
  Position position;
  Position positionInicial;
  bool bTelaAlterar = false;

  @override
  void initState() {
    super.initState();

    dynamic localizacao = widget._atividade.getRespostaAtividade();

    if (localizacao != null) {
      position = localizacao.getCoordenada();
      positionInicial = position;
      geolocator = position.toString();
      bLink = true;
      bTelaAlterar = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Text(
                'Registre a sua localização:',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                widget._atividade.getDescricao(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                'Necessário estar com o GPS do celular ativado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: ElevatedButton(
                    child: Text(
                      bTelaAlterar ? "Alterar posição" : "Posição atual",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green[500],
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () async {
                      geolocator = "Buscando informações...";
                      setState(() {});
                      await Geolocator.getCurrentPosition().then((value) => {position = value});
                      geolocator = position.toString();
                      bLink = true;
                      setState(() {});
                    },
                  ),
                ),
                if (bTelaAlterar)
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        "Checar posição",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green[500],
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () async {
                        geolocator = positionInicial.toString();
                        bLink = true;
                        setState(() {});
                      },
                    ),
                  ),
              ],
            ),
            TextButton(
              child: Text(
                geolocator,
                style: TextStyle(
                  fontSize: 20,
                  color: bLink ? Colors.blue : Colors.black,
                  decoration: bLink ? TextDecoration.underline : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  Util.abreGoogleMaps(geolocator);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Gravar',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      if (!validaCampos()) {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                            title: Text("Campo obrigatório"),
                            content: Text("É obrigatório adicionar a sua localização."),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("OK"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      }
                      widget._atividade.adicionaResposta(CaracteristicaLocalizacao(position));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validaCampos() {
    if (position == null) return false;

    return true;
  }
}
