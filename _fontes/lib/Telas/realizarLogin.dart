import 'package:TCC_II/Classes/GoogleSignInProvider.dart';
import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:provider/provider.dart';
import 'Aluno/carregarTema.dart';
import 'Professor/temasProfessor.dart';

class ClasseRealizarLogin extends StatefulWidget {
  bool bProfessor = false;
  ClasseRealizarLogin(this.bProfessor);

  @override
  RealizarLogin createState() => RealizarLogin();
}

class RealizarLogin extends State<ClasseRealizarLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[300],
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Faça login com sua conta da Google",
              style: TextStyle(fontSize: 30),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.only(bottom: 10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[500],
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                label: Text(
                  "Realizar login",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.googleLogin();
                  if (widget.bProfessor) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseProfessor()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCarregarTema()));
                  }
                },
              ),
            ),
            Text(
              "Caso você não tenha conta na Google, faça seu cadastro.",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.only(top: 15),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text(
                  "Voltar",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
