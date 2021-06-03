import 'dart:convert';

import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:TCC_II/Telas/aprendaUsar.dart';
import '../../GoogleAuthClient.dart';
import '../telaInicial.dart';
import 'cadastrarTema.dart';
import '../../Classes/Tema.dart';
import 'package:googleapis/drive/v3.dart' as v3;

class ClasseProfessor extends StatefulWidget {
  @override
  TemasProfessor createState() => TemasProfessor();
}

class TemasProfessor extends State<ClasseProfessor> with SingleTickerProviderStateMixin {
  List<Tema> _aTemas = [];
  int _index = 0;

  Animation _colorido;
  AnimationController _animationController;

  void initState() {
    _animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    _colorido = _animationController.drive(ColorTween(begin: Colors.yellow, end: Colors.blue));
    _animationController.repeat();
    super.initState();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (_aTemas.length > 0)
                    Text(
                      _aTemas[_index].getTema(),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                  if (_aTemas.length > 0)
                    TextButton(
                      child: QrImage(
                        backgroundColor: Colors.green[500],
                        data: carregaInfo(),
                        size: 200,
                      ),
                      style: TextButton.styleFrom(primary: Colors.green[300]),
                      onPressed: () {
                        chamaTelaCadastrarTema(context, _aTemas[_index]);
                      },
                    ),
                  if (_aTemas.length > 0)
                    ElevatedButton(
                      child: Text(
                        'Sincronizar tema com o Google Drive',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                      ),
                      onPressed: () async {
                        showLoadingDialog();
                        await postFileToGoogleDrive(_aTemas[_index]);
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Cadastrar Novo Tema",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                      onPressed: () {
                        _aTemas.add(new Tema());
                        chamaTelaCadastrarTema(context, _aTemas[_aTemas.length - 1]);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Próximo Tema",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _index == _aTemas.length - 1 ? _index = 0 : _index++;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Tema Anterior",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _index == 0 ? _index = _aTemas.length - 1 : _index--;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Aprenda a Usar",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseAprendaUsar()));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Voltar à Tela Inicial",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseTelaInicial()));
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

  void chamaTelaCadastrarTema(BuildContext context, Tema tema) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseTema(tema)));
    setState(() {});
  }

  String carregaInfo() {
    Tema temaAtual = _aTemas[_index];

    String infoAtual = temaAtual.getTema() + "¨§" + temaAtual.getDescricao() + "¨§" + temaAtual.getListaObjEspecifico().length.toString() + "¨§";

    for (ObjEspecifico it in temaAtual.getListaObjEspecifico()) {
      infoAtual += it.getObjetivo() + "¨§";
      infoAtual += it.getRoteiro().getOrdenado().toString() == "true" ? "1" : "0" + "¨§";
      infoAtual += it.getRoteiro().getQtdAtividades().toString() + "¨§";

      for (Atividade it in it.getRoteiro().getListaAtividade()) {
        infoAtual += it.getId().toString() + "¨§" + it.getNomeAtividade() + "¨§" + it.getDescricao() + "¨§";
      }
    }

    return infoAtual;
  }

  Future<void> postFileToGoogleDrive(Tema tema) async {
    final authHeaders = await Util.account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = v3.DriveApi(authenticateClient);

    v3.File folderTema = await criaTema(tema, driveApi);

    int qtdObj = 1;

    for (final objEspecifico in tema.getListaObjEspecifico()) {
      v3.File folderAtual = await criaObjetivoEspecifico(objEspecifico, folderTema, qtdObj, driveApi);

      folderAtual = await criaRoteiro(objEspecifico.getRoteiro(), folderAtual, driveApi);

      int qtdAtividade = 1;
      for (final atividade in objEspecifico.getRoteiro().getListaAtividade()) {
        await criaAtividade(atividade, folderAtual, qtdAtividade, driveApi);
        qtdAtividade++;
      }

      qtdObj++;
    }
  }

  Future<v3.File> criaTema(Tema tema, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Professor - ${tema.getTema()}";
    folderType.mimeType = "application/vnd.google-apps.folder";

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leTema(tema);

    await Util.gravaDados(values, "tema.txt", folder, driveApi);
    return folder;
  }

  Future<v3.File> criaObjetivoEspecifico(ObjEspecifico objEspecifico, v3.File folderAtual, int qtdObj, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "OE$qtdObj";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leObjEspecifico(objEspecifico);

    await Util.gravaDados(values, "objEspecifico.txt", folder, driveApi);
    return folder;
  }

  Future<v3.File> criaRoteiro(Roteiro roteiro, v3.File folderAtual, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Roteiro";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leRoteiro(roteiro);

    await Util.gravaDados(values, "roteiro.txt", folder, driveApi);
    return folder;
  }

  Future<void> criaAtividade(Atividade atividade, v3.File folderAtual, int qtdAtividade, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Atividade$qtdAtividade";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = utf8.encode('Atividade: ' + atividade.getNomeAtividade() + '\n');
    values += utf8.encode('Descricao: ' + atividade.getDescricao());

    await Util.gravaDados(values, "atividade.txt", folder, driveApi);
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(
              valueColor: _colorido,
              strokeWidth: 5,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: Text(
              'Gravando dados no Google Drive...',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
