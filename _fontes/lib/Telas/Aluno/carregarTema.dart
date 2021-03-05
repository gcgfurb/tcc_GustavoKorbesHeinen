import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:teste/Telas/Aluno/sozinhoGrupo.dart';

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
            Expanded(
              flex: 1,
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
        controller.dispose();
        //qrText = scanData.code;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseSozinhoGrupo()));
      });
    });
  }
}
