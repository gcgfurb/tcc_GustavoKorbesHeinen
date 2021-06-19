import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as v3;

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

  FocusNode _fnEmail;

  @override
  void initState() {
    super.initState();
    _fnEmail = FocusNode();
  }

  @override
  void dispose() {
    _fnEmail.dispose();
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
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 5, 0),
                    child: TextField(
                      focusNode: _fnEmail,
                      controller: _tecEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite o email do participante',
                        hintText: 'fulano@gmail.com',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 15, 15, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar email",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (validaCampos()) {
                          FocusManager.instance.primaryFocus.unfocus();
                          cadastrarParticipante();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: participantes.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text(
                        participantes[index].emailAddress,
                        style: TextStyle(fontSize: 15),
                      ),
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
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                      "Confirmar",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      widget._folderTema.permissions = participantes;

                      if (participantes.isEmpty) return;

                      for (int idx = 0; idx < participantes.length; ++idx) {
                        if (!participantes[idx].emailAddress.contains("@gmail.com")) {
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text("Email incorreto"),
                              content: Text("O email \"${participantes[idx].emailAddress}\" não possui uma assinatura Google (@gmail.com)"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text("OK"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      v3.DriveApi driveApi = await Util.getDriveApi();

                      for (int idx = 0; idx < participantes.length; ++idx) {
                        await driveApi.permissions.create(participantes[idx], widget._folderTema.id);
                      }

                      final scaffold = ScaffoldMessenger.of(context);
                      scaffold.showSnackBar(
                        SnackBar(
                          content: const Text('Pasta compartilhada'),
                        ),
                      );
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

    String email = _tecEmail.text.trim();

    permission.emailAddress = email;

    participantes.add(permission);
    _tecEmail.clear();
    setState(() {});
  }

  bool validaCampos() {
    if (_tecEmail.text.isEmpty) {
      _fnEmail.requestFocus();
      return false;
    }

    return true;
  }
}
