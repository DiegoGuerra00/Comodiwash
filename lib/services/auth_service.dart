import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Google auth
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  /// Gets the google user to do the authentication
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      // checks if user exists
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }

    notifyListeners();
  }

  /// Makes the logout from the current user
  Future googleLogout() async {
    try {
      await googleSignIn.disconnect();
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(
          msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  // Email auth

  /// Create an account with email and password
  Future emailCreateAccount(
      {required String email,
      required String password,
      required String name,
      required String surname}) async {
    try {
      String completeName = '$name $surname';

      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.currentUser!.updateDisplayName(completeName);
      notifyListeners();
      Fluttertoast.showToast(
          msg: 'Conta criada com sucesso', toastLength: Toast.LENGTH_LONG);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: 'A senha inserida é muito fraca',
            toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'Já existe uma conta associada a esta e-mail',
            toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Algo deu errado');
    }
  }

  /// Sign in in an already existing account with email
  Future emailLogin({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'Usuário não encontrado', toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: 'E-mail ou senha incorretos', toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Algo deu errado');
    }
  }

  /// Sends reset password email to the user email
  Future emailResetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          msg: 'E-mail enviado', toastLength: Toast.LENGTH_LONG);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'E-mail inválido', toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'Algo deu errado', toastLength: Toast.LENGTH_LONG);
    }
  }

  /// Sign out the current user
  void emailSignOut() {
    try {
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Fluttertoast.showToast(
          msg: 'Algo deu errado', toastLength: Toast.LENGTH_LONG);
    }
  }

  // Facebook auth
}
