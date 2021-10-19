import 'package:flutter/material.dart';
import 'package:patoburguer_admin/screens/tela_altera_senha.dart';
import 'package:patoburguer_admin/screens/tela_alterar_item.dart';

import 'components/auth_check.dart';

class PatoBurguerAdminApp extends StatelessWidget {
  const PatoBurguerAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFF9B0D),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthCheck(),
        '/alterar-senha': (context) => TelaAlteraSenha(),
        '/alterar-item': (context) => TelaAlterarItem(),
      },
    );
  }
}
