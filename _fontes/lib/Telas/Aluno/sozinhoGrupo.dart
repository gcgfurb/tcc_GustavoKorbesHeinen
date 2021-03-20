import 'package:flutter/material.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'cadastrarGrupo.dart';
import 'verTema.dart';

class ClasseSozinhoGrupo extends StatefulWidget {
  @override
  SozinhoGrupo createState() => SozinhoGrupo();
}

class SozinhoGrupo extends State<ClasseSozinhoGrupo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "Vou realizar as atividades:",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  color: Colors.green[500],
                  textColor: Colors.white,
                  child: Text("Sozinho"),
                  onPressed: () {
                    Tema _tema = criaTema();
                    chamaTelaVerTema(context, _tema);
                  },
                ),
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  color: Colors.green[500],
                  textColor: Colors.white,
                  child: Text("Em grupo"),
                  onPressed: () {
                    Tema _tema = criaTema();
                    chamaTelaEmGrupo(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Tema criaTema() {
    Tema _tema = new Tema();
    ObjEspecifico _objEspecifico = new ObjEspecifico();
    Roteiro _roteiro = new Roteiro();

    Atividade _atividade = new Atividade();
    _atividade.setId(-1);
    _atividade.setNomeAtividade("Procurar formiga saúva");
    _atividade.setDescricao("Essas formigas se encontram próximas as folhas");
    _roteiro.adicionaAtividade(_atividade);

    _atividade = new Atividade();
    _atividade.setId(-1);
    _atividade.setNomeAtividade("Tirar foto das formigas");
    _atividade.setDescricao("Chegar próximo a elas e tirar uma foto");
    _roteiro.adicionaAtividade(_atividade);
    _roteiro.setOrdenado(true);

    _objEspecifico.setRoteiro(_roteiro);
    _objEspecifico.setObjetivo("Encontrar formigas");
    _tema.adicionaObjEspecifico(_objEspecifico);

    _roteiro = new Roteiro();
    _objEspecifico = new ObjEspecifico();

    _atividade = new Atividade();
    _atividade.setId(-1);
    _atividade.setNomeAtividade("Procurar árvore de Araucária");
    _atividade.setDescricao("Ir próximo a um lugar onde possui árvores de araucária");
    _roteiro.adicionaAtividade(_atividade);

    _atividade = new Atividade();
    _atividade.setId(-1);
    _atividade.setNomeAtividade("Pegar uma parte do tronco");
    _atividade.setDescricao("Retirar uma parte do tronco da árvore para realizar estudos");
    _roteiro.adicionaAtividade(_atividade);
    _roteiro.setOrdenado(false);

    _objEspecifico.setRoteiro(_roteiro);
    _objEspecifico.setObjetivo("Determinar idade da árvore");

    _tema.adicionaObjEspecifico(_objEspecifico);
    _tema.setTema("Andar na floresta");
    _tema.setDescricao("Procurar formigas e árvore");

    return _tema;
  }
}

void chamaTelaVerTema(BuildContext context, Tema _tema) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseVerTema(_tema)));
}

void chamaTelaEmGrupo(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCadastrarGrupo()));
}
