import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patoburguer_admin/screens/AlterarCardapio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(PatoBurguerAdminApp());
}

class PatoBurguerAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      home: AlterarCardapio(),
    );
  }
}
