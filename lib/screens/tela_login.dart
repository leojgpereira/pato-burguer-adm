import 'package:flutter/material.dart';
import 'package:patoburguer_admin/models/auth_exception.dart';
import 'package:patoburguer_admin/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 135.0,
              bottom: 25.0,
            ),
            child: Container(
              width: (MediaQuery.of(context).size.width * 0.85),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  FormularioLogin(),
                  FractionalTranslation(
                    translation: Offset(-0.05, -0.61),
                    child: Image.asset('assets/images/logo_pato_burguer.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormularioLogin extends StatefulWidget {
  const FormularioLogin({Key? key}) : super(key: key);

  @override
  _FormularioLoginState createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final TextEditingController _usuario = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Color corTexto = const Color(0xFF434343);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 55.0,
          ),
          Text(
            'Login',
            style: TextStyle(
              color: corTexto,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 22.0,
          ),
          TextFormField(
            controller: _usuario,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira um usuário';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              hintText: 'Usuário',
            ),
          ),
          SizedBox(
            height: 18.0,
          ),
          TextFormField(
            controller: _senha,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira uma senha';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              hintText: 'Senha',
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          GestureDetector(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Esqueceu a senha?',
                style: TextStyle(
                  color: corTexto,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            onTap: () {},
          ),
          SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _signIn(context);
              }
            },
            child: Text(
              'Entrar',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Theme.of(context).primaryColor,
              minimumSize: Size(double.infinity, 55.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _signIn(BuildContext context) async {
    AuthService auth = context.read<AuthService>();

    try {
      await auth.signIn(_usuario.text, _senha.text);
    } on AuthException catch (e) {
      final loginFeedback = SnackBar(
        content: Text(
          e.message,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(loginFeedback);
    }
  }
}
