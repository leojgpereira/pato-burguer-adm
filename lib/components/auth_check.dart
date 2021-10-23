import 'package:flutter/material.dart';
import 'package:patoburguer_admin/screens/tela_inicio.dart';
import 'package:patoburguer_admin/screens/tela_login.dart';
import 'package:patoburguer_admin/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.usuario == null) {
      return TelaLogin();
    } else {
      return TelaInicio();
    }
  }
}
