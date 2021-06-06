import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Util.dart';

import 'package:TCC_II/Telas/Aluno/shareFolder.dart';
import 'package:TCC_II/Telas/Aluno/cadastrarObjEspecifico.dart';
import 'package:TCC_II/Telas/Aluno/visualizarRoteiroDefinido.dart';
import 'package:TCC_II/Telas/Aluno/visualizarRoteiroNaoDefinido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:googleapis/drive/v3.dart' as v3;
import '../../Classes/Constantes.dart' as Constantes;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ClasseVerTema extends StatefulWidget {
  Tema _tema = new Tema();
  ClasseVerTema(this._tema);

  @override
  VerTema createState() => VerTema();
}

class VerTema extends State<ClasseVerTema> with SingleTickerProviderStateMixin {
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
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(5, 15, 0, 5),
              child: Text(
                'Tema: ' + widget._tema.getTema(),
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: Text(
                  'Descrição: ' + widget._tema.getDescricao(),
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: widget._tema.getListaObjEspecifico().length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.bookmarks),
                        title: Text('${widget._tema.getObjEspecifico(index).getObjetivo()}'),
                        dense: true,
                        trailing: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.green[500],
                          textColor: Colors.white,
                          child: Text("Realizar atividades"),
                          onPressed: () {
                            chamaTelaRealizarAtividades(context, widget._tema.getObjEspecifico(index));
                          },
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text("Enviar respostas ao Professor"),
                    onPressed: () async {
                      showLoadingDialog();
                      v3.File folderTema = await postFileToGoogleDrive(widget._tema);
                      Navigator.pop(context);
                      shareFolder(folderTema);
                    },
                  ),
                ),
                if (!widget._tema.getObjDefinido() || !widget._tema.getRoteiroDefinido())
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text("Cadastrar novo Objetivo Específico"),
                      onPressed: () {
                        chamaTelaNovoObjEspecifico(context, widget._tema);
                      },
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void chamaTelaRealizarAtividades(context, ObjEspecifico _objEspecifico) async {
    if (_objEspecifico.getRoteiro().getQtdAtividades() > 0) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroDefinido(_objEspecifico)));
    } else {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroNaoDefinido(_objEspecifico)));
      setState(() {});
    }
  }

  void chamaTelaNovoObjEspecifico(context, Tema _tema) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseObjEspecifico(_tema)));
    setState(() {});
  }

  Future<void> shareFolder(v3.File folderTema) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Compartilhar tema"),
        content: Text("Deseja compartilhar o conteúdo no Google Drive?"),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Não"),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text("Sim"),
            onPressed: () async {
              Navigator.pop(context);
              await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseShareFolder(folderTema)));
            },
          ),
        ],
      ),
    );
  }

  Future<v3.File> postFileToGoogleDrive(Tema tema) async {
    v3.File folderTema = await criaTema(tema, Util.driveApi);

    int qtdObj = 1;

    for (final objEspecifico in tema.getListaObjEspecifico()) {
      v3.File folderAtual = await criaObjetivoEspecifico(objEspecifico, folderTema, qtdObj, Util.driveApi);

      folderAtual = await criaRoteiro(objEspecifico.getRoteiro(), folderAtual, Util.driveApi);

      int qtdAtividade = 1;
      for (final atividade in objEspecifico.getRoteiro().getListaAtividade()) {
        await criaAtividade(atividade, folderAtual, qtdAtividade, Util.driveApi);
        qtdAtividade++;
      }

      qtdObj++;
    }

    return folderTema;
  }

  Future<v3.File> criaTema(Tema tema, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Clube de Ciencias - ${tema.getTema()}";
    folderType.mimeType = "application/vnd.google-apps.folder";

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leTema(tema);

    await Util.gravaDados(values, Constantes.ARQUIVO_TEMA, folder, driveApi);
    return folder;
  }

  Future<v3.File> criaObjetivoEspecifico(ObjEspecifico objEspecifico, v3.File folderAtual, int qtdObj, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "OE$qtdObj";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leObjEspecifico(objEspecifico);

    await Util.gravaDados(values, Constantes.ARQUIVO_OBJETIVO_ESPECIFICO, folder, driveApi);
    return folder;
  }

  Future<v3.File> criaRoteiro(Roteiro roteiro, v3.File folderAtual, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Roteiro";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leRoteiro(roteiro);

    await Util.gravaDados(values, Constantes.ARQUIVO_ROTEIRO, folder, driveApi);
    return folder;
  }

  Future<void> criaAtividade(Atividade atividade, v3.File folderAtual, int qtdAtividade, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Atividade$qtdAtividade";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leAtividade(atividade);

    await Util.gravaDados(values, Constantes.ARQUIVO_ATIVIDADE, folder, driveApi);
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
