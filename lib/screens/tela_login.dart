import 'package:flutter/material.dart';
import 'package:patoburguer_admin/models/auth_exception.dart';
import 'package:patoburguer_admin/services/auth_service.dart';
import 'package:provider/src/provider.dart';

class TelaLogin extends StatefulWidget {
  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController _usuario = TextEditingController();
  TextEditingController _senha = TextEditingController();

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
                  Column(
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
                          color: Color(0xFF434343),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 22.0,
                      ),
                      TextFormField(
                        controller: _usuario,
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
                              color: Color(0xFF434343),
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
                          await _signIn(context);
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
                          primary: Color(0xFFFF9B0D),
                          minimumSize: Size(double.infinity, 55.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
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
