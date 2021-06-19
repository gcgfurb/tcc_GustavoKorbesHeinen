import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Telas/Aluno/verTema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Pessoa.dart';

class ClasseCadastrarGrupo extends StatefulWidget {
  Tema _tema = new Tema();
  ClasseCadastrarGrupo(this._tema);

  @override
  CadastrarGrupo createState() => CadastrarGrupo();
}

class CadastrarGrupo extends State<ClasseCadastrarGrupo> {
  List<Pessoa> _participantes = [];
  int _index = 0;
  TextEditingController _tecParticipantes = new TextEditingController();

  FocusNode _fnParticipantes;

  @override
  void initState() {
    super.initState();
    _fnParticipantes = FocusNode();
  }

  @override
  void dispose() {
    _fnParticipantes.dispose();
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
                      focusNode: _fnParticipantes,
                      controller: _tecParticipantes,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite o nome do participante',
                        hintText: 'Fulano da Silva',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 15, 15, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      color: Colors.green[500],
                      textColor: Colors.white,
                      child: Text(
                        "Cadastrar Usuário",
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
                  itemCount: _participantes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.green[100] : Colors.green[200],
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text(
                          _participantes[index].getNome(),
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
                                FocusManager.instance.primaryFocus.unfocus();
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
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    color: Colors.green[500],
                    textColor: Colors.white,
                    child: Text(
                      "Continuar",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus.unfocus();
                      chamaTelaVerTema(context);
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
        content: Text("Deseja excluir o participante " + _participantes[index].getNome() + "?"),
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
      _participantes.removeAt(index);
    });
  }

  void cadastrarParticipante() {
    _participantes.add(new Pessoa(_index++, _tecParticipantes.text));
    _tecParticipantes.clear();
    setState(() {});
  }

  void chamaTelaVerTema(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVerTema(widget._tema)));
    setState(() {});
  }

  void chamaTelaSozinhoOuGrupo(BuildContext context) {
    Navigator.pop(context);
  }

  bool validaCampos() {
    if (_tecParticipantes.text.isEmpty) {
      _fnParticipantes.requestFocus();
      return false;
    }

    return true;
  }
}
