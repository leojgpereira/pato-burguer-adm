import 'package:flutter/material.dart';
import 'package:patoburguer_admin/screens/AlterarCardapio.dart';
import 'package:patoburguer_admin/screens/Contato.dart';
import 'package:patoburguer_admin/screens/tela_altera_senha.dart';
import 'package:patoburguer_admin/screens/tela_alterar_produto.dart';

import 'components/auth_check.dart';

class PatoBurguerAdminApp extends StatelessWidget {
  const PatoBurguerAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFF9B0D),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthCheck(),
        '/alterar-senha': (context) => TelaAlteraSenha(),
        '/produtos': (context) => AlterarCardapio(),
        '/alterar-item': (context) => TelaAlterarProduto(),
        '/contato': (context) => Contato(),
      },
    );
  }
}
