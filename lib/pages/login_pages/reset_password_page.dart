import 'dart:async';

import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  bool canSendEmail = true;
  Timer? timer;
  int spamCount = 0;

  @override
  void initState() {
    super.initState();
  }

  /// Sends the password reset email and then awaits 5 minutes to enable the send button again
  Future resetPassword() async {
    setState(() {
      canSendEmail = false;
    });

    try {
      if (_formKey.currentState!.validate()) {
        final provider = Provider.of<AuthProvider>(context, listen: false);
        provider.emailResetPassword(email: _emailController.text.trim());
        spamCount++;
      }
    } catch (e) {
      print(e.toString());
    }

    timer = Timer.periodic(
        Duration(minutes: 5),
        (_) => {
              setState(() {
                canSendEmail = true;
              })
            });
    // await Future.delayed(Duration(minutes: 5));
  }

  /// Checks spam with the email
  /// 
  /// Blocks the button if either more than 5 requisitons were made or the last email was sent less than 5 minutes ago
  bool checkSpam() {
    if (spamCount <= 5 && canSendEmail) {
      return true;
    }

    return false;
  }

  /// Style of the formfield
  InputDecoration formDecoration(String hintText) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      border: OutlineInputBorder(),
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(45, 26, 71, 1)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  /// Returns TextFormField for the email field
  Widget emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: formDecoration('E-mail*'),
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }

  /// ElevatedButton to submit the password reset
  ///
  /// onPressed checks the bool canSendEmail to enable or disable the button
  Widget submitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: checkSpam() ? Color.fromRGBO(45, 26, 71, 1) : Colors.grey,
          onPrimary: Colors.white,
          minimumSize: Size(300, 50),
        ),
        onPressed: canSendEmail ? resetPassword : null,
        child: Text('Enviar'));
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: 'Esqueci minha senha', useTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Center(
                      child: Text(
                'Insira seu e-mail para recuperar a senha',
                style: TextStyle(fontSize: 24),
              ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              emailField(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              submitButton()
            ],
          ),
        ),
      ),
    );
  }
}
