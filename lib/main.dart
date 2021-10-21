import 'package:flutter/material.dart';
import 'package:patoburguer_admin/screens/Contato.dart';

void main() {
  runApp(PatoBurguerAdminApp());
}

class PatoBurguerAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Contato(),
    );
  }
}
