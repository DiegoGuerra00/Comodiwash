import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
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

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (loginError) {
      print(loginError.toString());
    }

    notifyListeners();
  }

  /// Makes the logout from the current user
  Future googleLogout() async {
    try {
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } catch (logoutError) {
      print(logoutError.toString());
    }
  }
}
