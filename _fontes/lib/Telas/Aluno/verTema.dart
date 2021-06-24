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
                        leading: Icon(Icons.now_widgets_outlined),
                        title: Text(
                          '${widget._tema.getObjEspecifico(index).getObjetivo()}',
                          style: TextStyle(fontSize: 15),
                        ),
                        dense: true,
                        trailing: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.green[500],
                          textColor: Colors.white,
                          child: Text(
                            "Realizar atividades",
                            style: TextStyle(fontSize: 15),
                          ),
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
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text(
                      "Voltar",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text(
                      "Enviar respostas ao Professor",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      if (!gravouTodasAtividades(widget._tema)) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                            title: Text("Respostas atividade"),
                            content: Text("É necessário responder todas as atividades do Tema"),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text("OK"),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        showLoadingDialog();
                        v3.File folderTema = await postFileToGoogleDrive(widget._tema);
                        Navigator.pop(context);
                        await shareFolder(folderTema);
                      }
                    },
                  ),
                ),
                Spacer(),
                if (!widget._tema.getObjDefinido())
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar novo Objetivo Específico",
                        style: TextStyle(fontSize: 20),
                      ),
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

  bool gravouTodasAtividades(Tema tema) {
    List<ObjEspecifico> objEspecificos = tema.getListaObjEspecifico();

    for (ObjEspecifico itObj in objEspecificos) {
      List<Atividade> atividades = itObj.getRoteiro().getListaAtividade();

      for (Atividade itAt in atividades) {
        if (itAt.getRespostaAtividade() == null) {
          return false;
        }
      }
    }

    return true;
  }

  void chamaTelaRealizarAtividades(context, ObjEspecifico _objEspecifico) async {
    if (widget._tema.getRoteiroDefinido()) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroDefinido(_objEspecifico)));
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text("Atividades?"),
          content: Text("Deseja Cadastrar ou Visualizar/Alterar as atividades do Roteiro?"),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text("Cadastrar"),
                onPressed: () async {
                  Navigator.pop(context);
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroNaoDefinido(_objEspecifico)));
                }),
            CupertinoDialogAction(
              child: Text("Visualizar"),
              onPressed: () async {
                Navigator.pop(context);
                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroDefinido(_objEspecifico)));
              },
            ),
          ],
        ),
      );

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
    v3.File folderTema = await criaTema(tema, await Util.getDriveApi());

    int qtdObj = 1;

    for (final objEspecifico in tema.getListaObjEspecifico()) {
      v3.File folderAtual = await criaObjetivoEspecifico(objEspecifico, folderTema, qtdObj, await Util.getDriveApi());

      folderAtual = await criaRoteiro(objEspecifico.getRoteiro(), folderAtual, await Util.getDriveApi());

      int qtdAtividade = 1;
      for (final atividade in objEspecifico.getRoteiro().getListaAtividade()) {
        await criaAtividade(atividade, folderAtual, qtdAtividade, await Util.getDriveApi());
        qtdAtividade++;
      }

      qtdObj++;
    }

    return folderTema;
  }

  Future<v3.File> criaTema(Tema tema, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "ExploraHabitat - ${tema.getTema()}";
    folderType.mimeType = "application/vnd.google-apps.folder";

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leTema(tema);

    await Util.gravaDados(values, Constantes.ARQUIVO_TEMA, folder);
    return folder;
  }

  Future<v3.File> criaObjetivoEspecifico(ObjEspecifico objEspecifico, v3.File folderAtual, int qtdObj, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "OE$qtdObj";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leObjEspecifico(objEspecifico);

    await Util.gravaDados(values, Constantes.ARQUIVO_OBJETIVO_ESPECIFICO, folder);
    return folder;
  }

  Future<v3.File> criaRoteiro(Roteiro roteiro, v3.File folderAtual, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Roteiro";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leRoteiro(roteiro);

    await Util.gravaDados(values, Constantes.ARQUIVO_ROTEIRO, folder);
    return folder;
  }

  Future<void> criaAtividade(Atividade atividade, v3.File folderAtual, int qtdAtividade, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Atividade$qtdAtividade";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leAtividade(atividade, folder);

    await Util.gravaDados(values, Constantes.ARQUIVO_ATIVIDADE, folder);
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
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
