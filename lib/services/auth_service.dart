import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:patoburguer_admin/models/auth_exception.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  Future signIn(String usuario, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: usuario, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        throw AuthException('Usuário e/ou senha inválidos!');
      } else {
        throw AuthException(
            'Erro na autenticação. Tente novamente mais tarde!');
      }
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException('Erro. Tente novamente mais tarde!');
    }
  }
}
