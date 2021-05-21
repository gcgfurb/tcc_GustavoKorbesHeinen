import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaFoto.dart';
import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:TCC_II/GoogleAuthClient.dart';
import 'package:TCC_II/Telas/Aluno/cadastrarObjEspecifico.dart';
import 'package:TCC_II/Telas/Aluno/visualizarRoteiroDefinido.dart';
import 'package:TCC_II/Telas/Aluno/visualizarRoteiroNaoDefinido.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:googleapis/drive/v3.dart' as v3;
import 'package:image_picker/image_picker.dart';
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
              padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
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
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => Center(
                                child: CircularProgressIndicator(
                                  valueColor: _colorido,
                                  strokeWidth: 5,
                                ),
                              ));
                      await postFileToGoogleDrive(widget._tema);
                      Navigator.pop(context);
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroDefinido(_objEspecifico)));
    } else {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseRoteiroNaoDefinido(_objEspecifico)));
      setState(() {});
    }
  }

  void chamaTelaNovoObjEspecifico(context, Tema _tema) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseObjEspecifico(_tema)));
    setState(() {});
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
    folderType.name = "Centro de Ciencias";
    folderType.mimeType = "application/vnd.google-apps.folder";

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leTema(tema);

    await gravaDados(values, "tema.txt", folder, driveApi);
    return folder;
  }

  Future<v3.File> criaObjetivoEspecifico(ObjEspecifico objEspecifico, v3.File folderAtual, int qtdObj, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "OE$qtdObj";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leObjEspecifico(objEspecifico);

    await gravaDados(values, "objEspecifico.txt", folder, driveApi);
    return folder;
  }

  Future<v3.File> criaRoteiro(Roteiro roteiro, v3.File folderAtual, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Roteiro";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leRoteiro(roteiro);

    await gravaDados(values, "roteiro.txt", folder, driveApi);
    return folder;
  }

  Future<void> criaAtividade(Atividade atividade, v3.File folderAtual, int qtdAtividade, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Atividade$qtdAtividade";
    folderType.mimeType = "application/vnd.google-apps.folder";
    folderType.parents = [folderAtual.id];

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    List<int> values = Util.leAtividade(atividade);

    await gravaDados(values, "atividade.txt", folder, driveApi);
  }

  Future<void> gravaDados(List<int> values, String nomeArquivo, v3.File folder, v3.DriveApi driveApi) async {
    final Stream<List<int>> mediaStream = Future.value(values).asStream().asBroadcastStream();
    var media = new v3.Media(mediaStream, values.length);

    var driveFile = new v3.File();
    driveFile.parents = [folder.id];
    driveFile.name = nomeArquivo;

    await driveApi.files.create(driveFile, uploadMedia: media);
  }

  Future<String> getFileFromGoogleDrive() async {
    final authHeaders = await Util.account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = v3.DriveApi(authenticateClient);
    v3.FileList textFileList = await driveApi.files.list();

    int idx = 0;
    while (textFileList.files[idx].name != "Centro de Ciencias") {
      idx++;
    }

    String content = "";

    v3.Media response = await driveApi.files.get(textFileList.files[8].id, downloadOptions: v3.DownloadOptions.fullMedia);

    List<int> dataStore = [];
    response.stream.listen((data) {
      print("DataReceived: ${data.length}");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () async {
      Directory tempDir = await getTemporaryDirectory(); //Get temp folder using Path Provider
      String tempPath = tempDir.path; //Get path to that location
      File file = File('$tempPath/test'); //Create a dummy file
      await file.writeAsBytes(dataStore); //Write to that file from the datastore you created from the Media stream
      content = file.readAsStringSync(); // Read String from the file
      print(content); //Finally you have your text
      print("Task Done");
      return content;
    }, onError: (error) {
      print("Some Error");
    });

    return content;
  }
}
