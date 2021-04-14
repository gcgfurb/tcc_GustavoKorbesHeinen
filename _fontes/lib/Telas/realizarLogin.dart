import 'package:TCC_II/Classes/Util.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
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
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Faça login com sua conta da Google",
              style: TextStyle(fontSize: 30),
            ),
            Container(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                color: Colors.green[500],
                textColor: Colors.white,
                child: Text("Realizar login"),
                onPressed: () {
                  chamaAPIGoogle();
                  if (widget.bProfessor) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseProfessor()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClasseCarregarTema()));
                  }
                },
              ),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 70),
            ),
            Text("Caso você não tenha conta na Google, faça seu cadastro."),
          ],
        ),
      ),
    );
  }
}

Future<void> chamaAPIGoogle() async {
  final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
  Util.account = await googleSignIn.signIn();
  print("User account " + Util.account.email);
}
