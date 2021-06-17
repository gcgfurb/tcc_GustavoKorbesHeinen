import 'package:TCC_II/Classes/Caracteristicas/CaracteristicaVivencia.dart';
import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Atividade.dart';

class ClasseVivencia extends StatefulWidget {
  Atividade _atividade = new Atividade();
  ClasseVivencia(this._atividade);

  @override
  Vivencia createState() => Vivencia();
}

class Vivencia extends State<ClasseVivencia> {
  TextEditingController _tecResposta = new TextEditingController();
  FocusNode _fnResposta;

  @override
  void initState() {
    super.initState();

    dynamic vivencia = widget._atividade.getRespostaAtividade();

    if (vivencia != null) {
      _tecResposta.text = vivencia.getResposta();
    }

    _fnResposta = FocusNode();
  }

  @override
  void dispose() {
    _fnResposta.dispose();
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
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                'Registe algo de interesse que foi vivenciado:',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15),
              child: Text(
                widget._atividade.getDescricao(),
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: TextField(
                controller: _tecResposta,
                focusNode: _fnResposta,
                maxLength: 150,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Experiencias vivenciadas*',
                  hintText: 'Encontrado folha da árvore de araucária',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    child: Text(
                      'Gravar',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      if (validaCampos()) {
                        widget._atividade.adicionaResposta(CaracteristicaVivencia(_tecResposta.text));
                        Navigator.pop(context);
                      }
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

  bool validaCampos() {
    if (_tecResposta.text.isEmpty) {
      _fnResposta.requestFocus();
      return false;
    }

    return true;
  }
}
