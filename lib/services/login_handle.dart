import 'package:comodiwash/pages/home_page.dart';
import 'package:comodiwash/pages/intro_page.dart';
import 'package:comodiwash/pages/login_pages/login_page.dart';
import 'package:comodiwash/services/themes/storage_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginHandle extends StatelessWidget {
  LoginHandle({Key? key}) : super(key: key);
  bool _viewIntro = false;

  /// Get the bool from shared preferences to check if the intro screen should be shown or not
  getIntroValue() {
    StorageManager.readData('viewIntro').then((value) => {
          if (value == 'true') {
            _viewIntro = true
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // getIntroValue();
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return HomePage();
            } else if (snapshot.hasError) {
              return Center(child: Text('Algo Deu Errado! Tente Novamente'));
            } else {
              return Login();
            }
          }),
    );
  }
}
