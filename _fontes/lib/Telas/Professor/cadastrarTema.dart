import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'cadastrarObjEspecificos.dart';

class ClasseTema extends StatefulWidget {
  Tema tema = new Tema();
  ClasseTema(this.tema);

  @override
  CadastrarTema createState() => CadastrarTema();
}

class CadastrarTema extends State<ClasseTema> {
  TextEditingController _tecTema;
  TextEditingController _tecDescricao;
  FocusNode _fnTema;
  FocusNode _fnDescricao;

  @override
  void initState() {
    super.initState();
    _tecTema = new TextEditingController(text: widget.tema.getTema());
    _tecDescricao = new TextEditingController(text: widget.tema.getDescricao());
    _fnTema = FocusNode();
    _fnDescricao = FocusNode();
  }

  @override
  void dispose() {
    _fnTema.dispose();
    _fnDescricao.dispose();
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
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                focusNode: _fnTema,
                controller: _tecTema,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cadastrar Tema*',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: TextField(
                focusNode: _fnDescricao,
                controller: _tecDescricao,
                maxLength: 150,
                maxLines: 7,
                decoration: InputDecoration(
                  labelText: 'Objetivo geral da atividade de campo*',
                  hintText: 'Procurar árvore araucária',
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              child: IntrinsicWidth(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      width: 300,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        color: Colors.green[500],
                        textColor: Colors.white,
                        child: Text(
                          "Cadastrar Objetivos Específicos para o Tema (opcional)",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          if (validaCampos()) chamaTelaCadastrarObjetivosEspecificos(context, widget.tema);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      width: 300,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        textColor: Colors.white,
                        color: Colors.green[500],
                        child: Text(
                          "Finalizar Tema e gerar QRCode",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          if (validaCampos()) finalizarTemaGerarQRCode();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void chamaTelaCadastrarObjetivosEspecificos(BuildContext context, Tema tema) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseObjEspecifico(tema)));
    setState(() {});
  }

  void finalizarTemaGerarQRCode() {
    widget.tema.setTema(_tecTema.text);
    widget.tema.setDescricao(_tecDescricao.text);

    Navigator.pop(context, widget.tema);
  }

  bool validaCampos() {
    if (_tecTema.text.isEmpty) {
      _fnTema.requestFocus();
      return false;
    } else if (_tecDescricao.text.isEmpty) {
      _fnDescricao.requestFocus();
      return false;
    }

    return true;
  }
}
