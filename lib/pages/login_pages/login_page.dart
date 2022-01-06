import 'dart:ui';
import 'package:comodiwash/pages/user_profile_pages/support_pages/privacy_policy_page.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmPasswordFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();
  final _surnameFormKey = GlobalKey<FormState>();
  bool isLogin = true;

  Widget genericSizedBox() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    );
  }

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
            // Spacer(),
            bannerLogo(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Form(
              key: _formKey,
              child: emailLoginField(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            isLogin ? googleLoginButton() : Container(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            isLogin ? facebookLoginButton() : Container(),
            // Spacer(),
            isLogin ? SizedBox(height: MediaQuery.of(context).size.height * 0.13) : Container(),
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

  Widget loginOptionsRow() {
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

  Widget emailLoginField() {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _confirmPassword = TextEditingController();
    TextEditingController _name = TextEditingController();
    TextEditingController _surname = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          loginOptionsRow(),
          Container(
              width: MediaQuery.of(context).size.width,
              child: emailForm(_email)),
          genericSizedBox(),
          passwordField(_password),
          genericSizedBox(),
          !isLogin ? confirmPasswordField(_confirmPassword) : Container(),
          !isLogin ? genericSizedBox() : Container(),
          !isLogin ? nameField(_name) : Container(),
          !isLogin ? genericSizedBox() : Container(),
          !isLogin ? surnameField(_surname) : Container(),
          !isLogin ? genericSizedBox() : Container(),
          loginConfirmButton(
              _email, _password, _confirmPassword, _name, _surname)
        ],
      ),
    );
  }

  Widget emailForm(TextEditingController _email) {
    return TextFormField(
      controller: _email,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'E-mail*',
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
    );
  }

  Widget passwordField(TextEditingController _password) {
    return TextFormField(
      controller: _password,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Senha*',
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira sua senha por favor';
        }
        if (value.length < 6) {
          return 'Senha deve possuir pelo menos 6 caracteres';
        }
        return null;
      },
    );
  }

  Widget confirmPasswordField(TextEditingController _confirmPassword) {
    return TextFormField(
      controller: _confirmPassword,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Confirme a senha*',
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira sua senha por favor';
        }
        return null;
      },
    );
  }

  Widget nameField(TextEditingController _name) {
    return TextFormField(
      controller: _name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Nome*',
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira seu nome por favor';
        }
        return null;
      },
    );
  }

  Widget surnameField(TextEditingController _surname) {
    return TextFormField(
      controller: _surname,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Sobrenome*',
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira seu sobrenome por favor';
        }
        return null;
      },
    );
  }

  Widget loginConfirmButton(
      TextEditingController _email,
      TextEditingController _password,
      TextEditingController _confirmPassword,
      TextEditingController _name,
      TextEditingController _surname) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(300, 50),
        ),
        onPressed: () {
          if (isLogin) {
            if (_formKey.currentState!.validate()) {
              final provider =
                  Provider.of<AuthProvider>(context, listen: false);
              provider.emailSignIn(
                  email: _email.text.trim(), password: _password.text.trim());
            }
          } else {
            if (_formKey.currentState!.validate()) {
              final provider =
                  Provider.of<AuthProvider>(context, listen: false);
              if (_password.text.trim() == _confirmPassword.text.trim()) {
                provider.emailCreateAccount(
                    email: _email.text.trim(), password: _password.text.trim());
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Aviso'),
                        content: Text(
                            'O login ou senha estão inválidos.\nRevise as informações ou altere sua senha em "esqueci minha senha"'),
                        actions: <Widget>[
                          TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text(
                                'Entendi',
                                style: TextStyle(
                                    color: Color.fromRGBO(45, 26, 71, 1)),
                              ))
                        ],
                      );
                    });
              }
            }
          }
        },
        child: isLogin ? const Text('Login') : const Text('Criar Conta'));
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
        body: SingleChildScrollView(child: buildBackground()));
  }
}
