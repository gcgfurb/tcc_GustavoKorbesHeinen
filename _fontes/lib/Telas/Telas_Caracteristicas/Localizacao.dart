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

    dynamic localizacao = widget._atividade.respostaAtividade;

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
              padding: EdgeInsets.fromLTRB(20, 10, 0, 5),
              child: Text('Registre a sua localização:'),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(widget._atividade.getDescricao()),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
              child: Text(
                'Necessário estar com o GPS do celular ativado',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 15,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: FloatingActionButton.extended(
                    heroTag: "btPosicao",
                    label: bTelaAlterar ? Text("Alterar posição") : Text("Posição atual"),
                    icon: Icon(Icons.location_on),
                    backgroundColor: Colors.green[500],
                    onPressed: () async {
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
                    child: FloatingActionButton.extended(
                      heroTag: "btChecarPosicao",
                      label: Text("Checar posição"),
                      icon: Icon(Icons.location_on),
                      backgroundColor: Colors.green[500],
                      onPressed: () async {
                        geolocator = positionInicial.toString();
                        bLink = true;
                        setState(() {});
                      },
                    ),
                  ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: FloatingActionButton.extended(
                    heroTag: "btPermissao",
                    label: Text("Permissão"),
                    icon: Icon(Icons.perm_device_info_rounded),
                    backgroundColor: Colors.green[500],
                    onPressed: () async {
                      await Geolocator.requestPermission().then((value) => {geolocator = ptBR(value)});
                      bLink = false;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: FloatingActionButton.extended(
                      heroTag: "btGravar",
                      label: Text("Gravar"),
                      backgroundColor: Colors.green,
                      onPressed: () {
                        if (!validaCampos()) {
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text("Campo obrigatório"),
                              content: Text("É obrigatório adicionar a sua localização."),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
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
                  Container(
                    width: 150,
                    child: FloatingActionButton.extended(
                      heroTag: "btCancelar",
                      label: Text("Cancelar"),
                      backgroundColor: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
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

  String ptBR(LocationPermission permissao) {
    switch (permissao) {
      case LocationPermission.always:
        return "Permitido utilizar sempre";
      case LocationPermission.whileInUse:
        return "Permitido utilizar apenas durante o uso";
      case LocationPermission.denied:
        return "Permissão bloqueada";
      case LocationPermission.deniedForever:
        return "Permissão bloqueada até reiniciar as configurações";
      default:
        return "Permissão não definida";
    }
  }
}
