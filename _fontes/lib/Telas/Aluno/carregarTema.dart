import 'package:TCC_II/Classes/ObjEspecifico.dart';
import 'package:TCC_II/Classes/Tema.dart';
import 'package:TCC_II/Classes/Roteiro.dart';
import 'package:TCC_II/Classes/Atividade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:TCC_II/Telas/Aluno/sozinhoGrupo.dart';

class ClasseCarregarTema extends StatefulWidget {
  @override
  CarregarTema createState() => CarregarTema();
}

class CarregarTema extends State<ClasseCarregarTema> {
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Text(
                "Aponte a câmera do seu celular para o QRCode",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                overlay: QrScannerOverlayShape(borderRadius: 10, borderColor: Colors.red, borderLength: 30, borderWidth: 10, cutOutSize: 200),
                onQRViewCreated: onQRCodeScanner,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onQRCodeScanner(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        controller.stopCamera();

        qrText = scanData.code;

        Tema tema = new Tema();
        tema = stringToDados(qrText);

        if (tema != null) {
          controller.dispose();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseSozinhoGrupo(tema)));
        } else {
          controller.resumeCamera();
        }
      });
    });
  }

  Tema stringToDados(String qrText) {
    Tema tema = new Tema();

    List<String> dados = qrText.split("¨§");

    try {
      tema.setTema(dados[0]);
      tema.setDescricao(dados[1]);

      int qtdObj = int.parse(dados[2]);
      tema.setObjDefinido(qtdObj > 0 ? true : false);

      int posicao = 3;
      for (int idxObjetivo = 0; idxObjetivo < qtdObj; ++idxObjetivo) {
        ObjEspecifico objEspecifico = new ObjEspecifico();
        objEspecifico.setObjetivo(dados[posicao++]);

        Roteiro roteiro = new Roteiro();
        roteiro.setOrdenado(dados[posicao++] == "1" ? true : false);

        int qtdAtividades = int.parse(dados[posicao++]);
        if (tema.getRoteiroDefinido() == false) {
          tema.setRoteiroDefinido(qtdAtividades > 0 ? true : false);
        }

        for (int idxAtividade = 0; idxAtividade < qtdAtividades; ++idxAtividade) {
          Atividade atividade = new Atividade();

          atividade.setId(int.parse(dados[posicao++]));
          atividade.setNomeAtividade(dados[posicao++]);
          atividade.setDescricao(dados[posicao++]);

          roteiro.adicionaAtividade(atividade);
        }

        objEspecifico.setRoteiro(roteiro);
        tema.adicionaObjEspecifico(objEspecifico);
      }

      return tema;
    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("Alerta"),
              content: Text("QRCode encontrado não condiz com informações do aplicativo"),
            );
          });
    }
  }
}
