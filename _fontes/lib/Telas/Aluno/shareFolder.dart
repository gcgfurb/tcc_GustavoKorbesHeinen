import 'package:TCC_II/Classes/Util.dart';
import 'package:TCC_II/Telas/Aluno/verTema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as v3;

import '../../GoogleAuthClient.dart';

class ClasseShareFolder extends StatefulWidget {
  v3.File _folderTema = new v3.File();
  ClasseShareFolder(this._folderTema);

  @override
  ShareFolder createState() => ShareFolder();
}

class ShareFolder extends State<ClasseShareFolder> {
  List<v3.Permission> participantes = [];
  int _index = 0;
  TextEditingController _tecEmail = new TextEditingController();

  FocusNode focusNodeObj;

  @override
  void initState() {
    super.initState();
    focusNodeObj = FocusNode();
  }

  @override
  void dispose() {
    focusNodeObj.dispose();
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 5, 10),
                child: TextField(
                  focusNode: focusNodeObj,
                  controller: _tecEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Digite o email do participante',
                    hintText: 'fulano@gmail.com',
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 15, 0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  color: Colors.green[500],
                  textColor: Colors.white,
                  child: Text("Cadastrar Participante"),
                  onPressed: () {
                    if (_tecEmail.text.isEmpty) {
                      focusNodeObj.requestFocus();
                    } else {
                      FocusManager.instance.primaryFocus.unfocus();
                      cadastrarParticipante();
                    }
                  },
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: participantes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.bookmarks),
                        title: Text(participantes[index].emailAddress),
                        dense: true,
                        trailing: Wrap(
                          spacing: 12,
                          children: <Widget>[
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.delete_forever,
                                size: 50,
                              ),
                              onPressed: () {
                                chamaDialogExcluirParticipante(context, index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text("Confirmar"),
                    onPressed: () async {
                      final authHeaders = await Util.account.authHeaders;
                      final authenticateClient = GoogleAuthClient(authHeaders);
                      final driveApi = v3.DriveApi(authenticateClient);

                      widget._folderTema.permissions = participantes;

                      for (int idx = 0; idx < participantes.length; ++idx) {
                        await driveApi.permissions.create(participantes[0], widget._folderTema.id);
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text("Voltar"),
                    onPressed: () {
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

  void chamaDialogExcluirParticipante(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Excluir participante"),
        content: Text("Deseja excluir o participante " + participantes[index].emailAddress + "?"),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Não"),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text("Sim"),
            onPressed: () {
              excluirParticipante(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void excluirParticipante(int index) {
    setState(() {
      participantes.removeAt(index);
    });
  }

  Future<void> cadastrarParticipante() async {
    v3.Permission permission = v3.Permission();

    permission.type = "user";
    permission.role = "reader";
    permission.emailAddress = _tecEmail.text;

    participantes.add(permission);
    _tecEmail.clear();
    setState(() {});
  }
}
