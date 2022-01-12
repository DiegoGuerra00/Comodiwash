import 'dart:async';
import 'package:comodiwash/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmail());
    }
  }

  Future sendVerificationEmail() async {
    setState(() {
      canResendEmail = false;
    });
    Future.delayed(Duration(minutes: 5));
    setState(() {
      canResendEmail = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  Future checkEmail() async {
    // reloads the current user
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isVerified
      ? HomePage()
      : Scaffold(
          appBar: AppBar(
              title: Text('Verifique seu e-mail',
                  style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              elevation: 0),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enviamos um e-mail para sua caixa de entrada',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: Size(300, 50),
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    icon: Icon(Icons.email),
                    label: Text('Reenviar e-mail')),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Color.fromRGBO(45, 26, 71, 1)),
                    ))
              ],
            ),
          ),
        );
}
