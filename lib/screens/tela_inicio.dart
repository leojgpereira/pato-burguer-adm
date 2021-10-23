import 'package:flutter/material.dart';
import 'package:patoburguer_admin/models/auth_exception.dart';
import 'package:patoburguer_admin/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class TelaInicio extends StatelessWidget {
  const TelaInicio({Key? key}) : super(key: key);

  final Color corTexto = const Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Cabecalho(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await _signout(context);
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem vindo a',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                    color: corTexto,
                  ),
                ),
                Text(
                  'Área Administrativa',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                    color: corTexto,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                ),
                Botao(
                  texto: 'Alterar Cardápio',
                  icone: 'assets/images/icons/alterar_cardapio.png',
                  callback: () {
                    Navigator.pushNamed(
                      context,
                      '/produtos',
                    );
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Botao(
                  texto: 'Alterar Contato',
                  icone: 'assets/images/icons/alterar_contato.png',
                  callback: () {
                    Navigator.pushNamed(
                      context,
                      '/contato',
                    );
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Botao(
                  texto: 'Alterar Senha',
                  icone: 'assets/images/icons/alterar_senha.png',
                  callback: () {
                    Navigator.pushNamed(context, '/alterar-senha');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signout(BuildContext context) async {
    AuthService auth = context.read<AuthService>();

    try {
      await auth.signOut();
    } on AuthException catch (e) {
      final signOutFeedback = SnackBar(
        content: Text(
          e.message,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(signOutFeedback);
    }
  }
}

class Cabecalho extends StatelessWidget {
  const Cabecalho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Pato ',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Color(0xFF333333),
          ),
        ),
        Text(
          'Burguer',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

class Botao extends StatelessWidget {
  final String texto;
  final String icone;
  final Function callback;

  const Botao({
    Key? key,
    required this.texto,
    required this.icone,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              texto,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Image.asset(
              icone,
              width: 38.0,
              height: 38.0,
            ),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        minimumSize: Size(double.infinity, 14.0),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
