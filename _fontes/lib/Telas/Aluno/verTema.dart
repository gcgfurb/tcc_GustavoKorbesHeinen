import 'package:TCC_II/Classes/Util.dart';
import 'package:TCC_II/GoogleAuthClient.dart';
import 'package:TCC_II/Telas/Aluno/cadastrarObjEspecifico.dart';
import 'package:TCC_II/Telas/Aluno/visualizarRoteiroDefinido.dart';
import 'package:TCC_II/Telas/Aluno/visualizarRoteiroNaoDefinido.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:googleapis/drive/v3.dart' as v3;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ClasseVerTema extends StatefulWidget {
  Tema _tema = new Tema();
  ClasseVerTema(this._tema);

  @override
  VerTema createState() => VerTema();
}

class VerTema extends State<ClasseVerTema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.green[300],
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: Text(
                  'Tema: ' + widget._tema.getTema(),
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: Text(
                  'Descrição: ' + widget._tema.getDescricao(),
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 250,
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
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text("Enviar respostas ao Professor"),
                    onPressed: () {
                      postFileToGoogleDrive(widget._tema);
                    },
                  ),
                ),
                if (!widget._tema.getObjDefinido())
                  Container(
                    alignment: Alignment.bottomLeft,
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

    //----- Criação do Folder -----//

    v3.File folderType = new v3.File();
    folderType.name = "Centro de Ciências";
    folderType.mimeType = "application/vnd.google-apps.folder";

    v3.File folder = await driveApi.files.create(folderType, $fields: "id");

    //----- Criação do Folder -----//

    //----- Criação do Arquivo -----//

    /*v3.File fileType = new v3.File();
    fileType.name = "tema.json";
    fileType.mimeType = "application / vnd.google - apps.file";
    fileType.parents = [folder.id];

    v3.File file = await driveApi.files.create(fileType);
    print("File ID: " + file.id);*/

    //var file = File('file.txt');
    //file.writeAsString(tema.getTema());

    final Stream<List<int>> mediaStream = Future.value([104, 105]).asStream().asBroadcastStream();
    var media = new v3.Media(mediaStream, 2);

    var driveFile = new v3.File();
    driveFile.parents = [folder.id];
    driveFile.name = "hello_world.txt";

    final result = await driveApi.files.create(driveFile, uploadMedia: media);
    print("Upload result: $result");
  }

  Future<void> getFileFromGoogleDrive() async {
    final authHeaders = await Util.account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = v3.DriveApi(authenticateClient);
    v3.FileList textFileList = await driveApi.files.list(q: "'root' in parents");

    v3.Media response = await driveApi.files.get("1zNCKXDbRu5mBXISf_FT2d5myPSnTIksb", downloadOptions: v3.DownloadOptions.fullMedia);

    List<int> dataStore = [];
    response.stream.listen((data) {
      print("DataReceived: ${data.length}");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () async {
      Directory tempDir = await getTemporaryDirectory(); //Get temp folder using Path Provider
      String tempPath = tempDir.path; //Get path to that location
      File file = File('$tempPath/test'); //Create a dummy file
      await file.writeAsBytes(dataStore); //Write to that file from the datastore you created from the Media stream
      String content = file.readAsStringSync(); // Read String from the file
      print(content); //Finally you have your text
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
  }
}
