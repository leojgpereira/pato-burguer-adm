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

  Future _checkPassword(User user, String senhaAtual) async {
    AuthCredential credentials = EmailAuthProvider.credential(
      email: user.email!,
      password: senhaAtual,
    );

    try {
      await user.reauthenticateWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AuthException("Senha atual incorreta!");
      } else {
        throw AuthException("Erro! Tente novamente mais tarde.");
      }
    }
  }

  Future updatePassword(String senhaAtual, novaSenha) async {
    User? user = await _auth.currentUser;

    if (user != null) {
      final checaSenha = await _checkPassword(user, senhaAtual);

      if (checaSenha == null) {
        try {
          await user.updatePassword(novaSenha);
        } on FirebaseAuthException catch (e) {
          throw AuthException("Erro! Tente novamente mais tarde.");
        }
      } else {
        return checaSenha;
      }
    } else {
      throw AuthException('Usuário não identificado!');
    }
  }
}
