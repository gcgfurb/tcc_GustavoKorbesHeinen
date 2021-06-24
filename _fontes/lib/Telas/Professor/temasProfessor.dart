import 'dart:convert';

import 'package:TCC_II/Classes/Atividade.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../telaInicial.dart';
import 'cadastrarTema.dart';
import '../../Classes/Tema.dart';
import 'package:googleapis/drive/v3.dart' as v3;
import '../../Classes/Constantes.dart' as Constantes;

class ClasseProfessor extends StatefulWidget {
  @override
  TemasProfessor createState() => TemasProfessor();
}

class TemasProfessor extends State<ClasseProfessor> with SingleTickerProviderStateMixin {
  List<Tema> _temas = [];
  int _index = 0;
  List<Tema> _temasGoogleDrive = [];
  int idxObjEspGD = 0;

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
                  if (_temas.length > 0)
                    Text(
                      _temas[_index].getTema(),
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.justify,
                    ),
                  if (_temas.length > 0)
                    TextButton(
                      child: QrImage(
                        backgroundColor: Colors.green[500],
                        data: carregaInfo(),
                        size: 200,
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(1),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {
                        chamaTelaCadastrarTema(context, _temas[_index]);
                      },
                    ),
                  if (_temas.length > 0)
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: ElevatedButton(
                        child: Text(
                          'Sincronizar tema com o Google Drive',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () async {
                          showLoadingDialog("Gravando dados no Google Drive...");
                          await postFileToGoogleDrive(_temas[_index]);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: ElevatedButton(
                      child: Text(
                        'Escolher Tema no Google Drive',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () async {
                        _temasGoogleDrive.clear();
                        showLoadingDialog("Buscando temas do Google Drive...");
                        await getFileFromGoogleDrive();
                        Navigator.pop(context);

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.green[100],
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Temas encontrados'),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.close,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              content: mostraTema(_temasGoogleDrive),
                            );
                          },
                        );
                      },
                    ),
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
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Cadastrar novo tema",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        _temas.add(new Tema());
                        chamaTelaCadastrarTema(context, _temas[_temas.length - 1]);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Próximo Tema",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        if (_temas.isNotEmpty)
                          setState(() {
                            _index == _temas.length - 1 ? _index = 0 : _index++;
                          });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Tema Anterior",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        if (_temas.isNotEmpty)
                          setState(() {
                            _index == 0 ? _index = _temas.length - 1 : _index--;
                          });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Excluir Tema",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        if (_temas.isNotEmpty)
                          setState(() {
                            _temas.removeAt(_index);
                            _index = 0;
                          });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8, vertical: 0),
                    child: ElevatedButton(
                      child: Text(
                        "Voltar à Tela Inicial",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
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
    Tema temaAtual = _temas[_index];

    String infoAtual = temaAtual.getTema() + "¨§" + temaAtual.getDescricao() + "¨§" + temaAtual.getListaObjEspecifico().length.toString() + "¨§";

    for (ObjEspecifico it in temaAtual.getListaObjEspecifico()) {
      infoAtual += it.getObjetivo() + "¨§";
      infoAtual += (it.getRoteiro().getOrdenado().toString() == "true" ? "1" : "0") + "¨§";
      infoAtual += it.getRoteiro().getQtdAtividades().toString() + "¨§";

      for (Atividade it in it.getRoteiro().getListaAtividade()) {
        infoAtual += it.getId().toString() + "¨§" + it.getNomeAtividade() + "¨§" + it.getDescricao() + "¨§";
      }
    }

    return infoAtual;
  }

  Future<void> postFileToGoogleDrive(Tema tema) async {
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
  }

  Future<v3.File> criaTema(Tema tema, v3.DriveApi driveApi) async {
    v3.File folderType = new v3.File();
    folderType.name = "Professor - ${tema.getTema()}";
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

    List<int> values = utf8.encode('Atividade: ' + atividade.getNomeAtividade() + '\n');
    values += utf8.encode('Descricao: ' + atividade.getDescricao());

    await Util.gravaDados(values, Constantes.ARQUIVO_ATIVIDADE, folder);
  }

  Widget mostraTema(List<Tema> tema) {
    List<int> idxTema = [];

    return Container(
      height: 300.0,
      width: 300.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tema.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(2),
            child: ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: (index % 2 == 0) ? Colors.green[300] : Colors.green[500]),
              onPressed: () {
                if (idxTema.contains(index)) return;
                idxTema.add(index);
                _temas.add(_temasGoogleDrive[index]);
                setState(() {});
              },
              child: ListTile(
                title: Text(
                  tema[index].getTema(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getFileFromGoogleDrive() async {
    v3.DriveApi driveApi = await Util.getDriveApi();
    v3.FileList temasDriveProfessor = await driveApi.files.list(q: "mimeType = 'application/vnd.google-apps.folder' and name contains 'Professor - ' and trashed = false");

    for (int idxTemas = 0; idxTemas < temasDriveProfessor.files.length; ++idxTemas) {
      _temasGoogleDrive.add(new Tema());
      idxObjEspGD = 0;
      await getRecursaoTema(temasDriveProfessor.files[idxTemas], idxTemas);
    }
  }

  Future<void> getRecursaoTema(v3.File file, int idxTemaGD) async {
    v3.DriveApi driveApi = await Util.getDriveApi();
    v3.FileList temaDrive = await driveApi.files.list(q: "parents in '${file.id}'");

    for (int idxFile = 0; idxFile < temaDrive.files.length; ++idxFile) {
      if (temaDrive.files[idxFile].mimeType == "text/plain") {
        v3.Media content = await driveApi.files.get(temaDrive.files[idxFile].id, downloadOptions: v3.DownloadOptions.fullMedia);

        String texto = await getTexto(content);

        switch (temaDrive.files[idxFile].name) {
          case Constantes.ARQUIVO_TEMA:
            int iPos = texto.indexOf("Descricao: ");
            _temasGoogleDrive[idxTemaGD].setTema(texto.substring(6, iPos - 1));
            _temasGoogleDrive[idxTemaGD].setDescricao(texto.substring(iPos + 11, texto.length));

            break;
          case Constantes.ARQUIVO_OBJETIVO_ESPECIFICO:
            if (_temasGoogleDrive[idxTemaGD].getObjEspecifico(idxObjEspGD - 1).getObjetivo().isEmpty) {
              _temasGoogleDrive[idxTemaGD].getObjEspecifico(idxObjEspGD - 1).setObjetivo(texto.substring(10, texto.length));
            } else {
              ObjEspecifico objEspecifico = new ObjEspecifico();
              objEspecifico.setObjetivo(texto.substring(10, texto.length));

              _temasGoogleDrive[idxTemaGD].adicionaObjEspecifico(objEspecifico);
            }

            break;
          case Constantes.ARQUIVO_ROTEIRO:
            if (_temasGoogleDrive[idxTemaGD].getListaObjEspecifico().length <= idxObjEspGD) {
              _temasGoogleDrive[idxTemaGD].adicionaObjEspecifico(new ObjEspecifico());
              _temasGoogleDrive[idxTemaGD].getObjEspecifico(idxObjEspGD).setRoteiro(new Roteiro());
            }

            String ordenado = texto.substring(10, texto.length);
            _temasGoogleDrive[idxTemaGD].getObjEspecifico(idxObjEspGD).getRoteiro().setOrdenado(ordenado == "Sim" ? true : false);

            idxObjEspGD++;

            break;
          case Constantes.ARQUIVO_ATIVIDADE:
            if (_temasGoogleDrive[idxTemaGD].getListaObjEspecifico().length <= idxObjEspGD) {
              _temasGoogleDrive[idxTemaGD].adicionaObjEspecifico(new ObjEspecifico());
              _temasGoogleDrive[idxTemaGD].getObjEspecifico(idxObjEspGD).setRoteiro(new Roteiro());
            }

            Atividade atividade = new Atividade();

            int iPos = texto.indexOf("Descricao: ");
            atividade.setNomeAtividade(texto.substring(11, iPos - 1));
            atividade.setDescricao(texto.substring(iPos + 11, texto.length));
            atividade.setId(Util.stringToId(atividade.getNomeAtividade()));

            _temasGoogleDrive[idxTemaGD].getObjEspecifico(idxObjEspGD).getRoteiro().adicionaAtividade(atividade);

            break;
        }
      } else {
        await getRecursaoTema(temaDrive.files[idxFile], idxTemaGD);
      }
    }
  }

  Future<String> getTexto(v3.Media content) async {
    List<int> dataStore = [];

    Stream<List<int>> stream = content.stream;
    await for (var data in stream) {
      dataStore += data;
    }

    return utf8.decode(dataStore);
  }

  void showLoadingDialog(String mensagem) {
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
              mensagem,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
