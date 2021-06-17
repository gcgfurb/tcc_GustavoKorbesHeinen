import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Telas/telaInicial.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExploraHabitat',
      home: ClasseTelaInicial(),
    );
  }
}
