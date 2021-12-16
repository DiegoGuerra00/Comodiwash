import 'dart:ui';
import 'package:comodiwash/pages/user_profile_pages/support_pages/privacy_policy_page.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailFormKey = GlobalKey<FormState>();
  bool isLogin = true;

  /// Create a container with gradient for the purple background and the column with the buttons
  Widget buildBackground() {
    return Stack(
      children: [
        Container(
            // Top purple widget
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(31),
                bottomRight: Radius.circular(31),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple.shade900,
                    Color.fromRGBO(45, 26, 71, 1),
                  ]),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            bannerLogo(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            emailLoginField(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            googleLoginButton(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            facebookLoginButton(),
            Spacer(),
            privacyButton(),
          ],
        ),
      ],
    );
  }

  /// Return ClipRect with the logo
  Widget bannerLogo() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/comodiwash_login_banner.png'));
  }

  /// Elevated button for login with google
  ///
  /// When clicked calls the provider GoogleSignInProvider and the googleLogin metod
  Widget googleLoginButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        primary: Color.fromRGBO(64, 139, 255, 1), //background
        onPrimary: Colors.white, //font
        minimumSize: Size(300, 50),
      ),
      label: Text("Login com Google"),
      icon: FaIcon(FontAwesomeIcons.google),
      onPressed: () {
        final provider = Provider.of<AuthProvider>(context, listen: false);
        provider.googleLogin();
      },
    );
  }

  /// Elevated button for login with facebook
  /// TODO add login with facebook
  Widget facebookLoginButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        primary: Color.fromRGBO(59, 89, 152, 1), //background
        onPrimary: Colors.white, //font
        minimumSize: Size(300, 50),
      ),
      label: Text("Login com Facebook"),
      icon: FaIcon(FontAwesomeIcons.facebook),
      onPressed: () => print("Apertado Face"),
    );
  }

  Widget emailLoginField() {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

    return Form(
        key: _emailFormKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              createAccountRow(),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira seu e-mail por favor';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Senha',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                obscureText: true,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira sua senha por favor';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(300, 50),
                  ),
                  onPressed: () {
                    if (isLogin) {
                      final provider =
                          Provider.of<AuthProvider>(context, listen: false);
                      provider.emailSignIn(
                          email: _email.text.trim(),
                          password: _password.text.trim());
                    } else {
                      final provider =
                          Provider.of<AuthProvider>(context, listen: false);
                      provider.emailCreateAccount(
                          email: _email.text.trim(),
                          password: _password.text.trim());
                    }
                  },
                  child: isLogin ? const Text('Login') : const Text('Criar Conta'))
            ],
          ),
        ));
  }

  Widget createAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text('Login',
                style: TextStyle(
                    fontSize: 16,
                    decoration: isLogin
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    color: Colors.white))),
        SizedBox(width: MediaQuery.of(context).size.width * 0.2),
        TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text('Criar Conta',
                style: TextStyle(
                    fontSize: 16,
                    decoration: !isLogin
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    color: Colors.white))),
      ],
    );
  }

  /// TextButton that leads to the privacy policy page
  Widget privacyButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => PrivacyPolicyPage()));
        },
        child: Text(
          'Política de Privacidade',
          style: TextStyle(color: Colors.grey),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildBackground(),
    );
  }
}
