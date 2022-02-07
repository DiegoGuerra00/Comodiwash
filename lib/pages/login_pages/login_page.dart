import 'dart:ui';
import 'package:comodiwash/pages/login_pages/reset_password_page.dart';
import 'package:comodiwash/pages/user_profile_pages/support_pages/eula_page.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    primary: Colors.white,
    onPrimary: Colors.black,
    minimumSize: Size(300, 50),
  );

  /// Returns InputDecoration for the TextFormFields.
  ///
  /// @parameters
  /// String hintText String containing the text to be used as hint for that specific textfield
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

  /// SizedBox used only for spacing porposes
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
            isLogin
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.10)
                : SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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

  /// Button to switch between login and sign in fiels
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

  /// Form to get user data for login with email and password
  /// using firebase auth
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
          !isLogin
              ? confirmPasswordField(_confirmPassword, _password)
              : Container(),
          !isLogin ? genericSizedBox() : Container(),
          !isLogin ? nameField(_name) : Container(),
          !isLogin ? genericSizedBox() : Container(),
          !isLogin ? surnameField(_surname) : Container(),
          !isLogin ? genericSizedBox() : Container(),
          loginConfirmButton(_email, _password, _name, _surname),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
          ),
          passwordResetButton(_email)
        ],
      ),
    );
  }

  /// TextForm field to get user email.
  ///
  ///@parameters
  ///TextEditingController _email TextEditingController to store the input from the user
  ///
  /// Is used in login and sign in
  Widget emailForm(TextEditingController _email) {
    return TextFormField(
      controller: _email,
      decoration: formDecoration('E-mail*'),
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'E-mail Inválido';
        }
        return null;
      },
    );
  }

  /// TextForm field to get user password.
  ///
  ///@parameters
  ///TextEditingController _password TextEditingController to store the input from the user
  ///
  /// Is used in login and sign in
  Widget passwordField(TextEditingController _password) {
    return TextFormField(
      controller: _password,
      decoration: formDecoration('Senha*'),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        if (value.length < 6) {
          return 'Senha deve possuir pelo menos 6 caracteres';
        }
        if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])$').hasMatch(value) && !isLogin) {
          return 'Sua senha deve possuir pelo menos um caractere maiúsculo, \num minúsculo e um número';
        }
        return null;
      },
    );
  }

  /// TextForm field to get confirm the password.
  ///
  /// Used only on sign up
  Widget confirmPasswordField(
      TextEditingController _confirmPassword, TextEditingController _password) {
    return TextFormField(
      controller: _confirmPassword,
      decoration: formDecoration('Confirme sua senha*'),
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        if (value != _password.text.trim()) {
          return 'As senhas não conferem';
        }
        if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])$').hasMatch(value) && !isLogin) {
          return 'Sua senha deve possuir pelo menos um caractere maiúsculo, \num minúsculo e um número';
        }
        return null;
      },
    );
  }

  /// TextField to get user name.
  ///
  ///@parameters
  ///TextEditingController _name TextEditingController to store the input from the user
  ///
  /// Used only on sign up
  Widget nameField(TextEditingController _name) {
    return TextFormField(
      controller: _name,
      decoration: formDecoration('Nome*'),
      obscureText: false,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }

  /// TextField to get user surname.
  ///
  ///@parameters
  ///TextEditingController _surmane TextEditingController to store the input from the user
  ///
  /// User only on sign in
  Widget surnameField(TextEditingController _surname) {
    return TextFormField(
      controller: _surname,
      decoration: formDecoration('Sobrenome*'),
      obscureText: false,
      autocorrect: false,
      enableSuggestions: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }

  /// ElevatedButton used to login or sign up.
  ///
  /// @parameters
  /// TextEditingController _email The user email
  /// TextEditingController _password The user password
  ///TextEditingController _name The user name
  ///TextEditingController _surname The user surmane
  ///
  /// If the bool isLogin is true acts as login button calling the emailLogin method from AuthProvider.
  /// If the bool isLogin is false acts as sign up button calling the emailCreateAccount method from AuthProvider.
  ///
  /// Each field has it's own validation from TextFormFIeld validator
  Widget loginConfirmButton(
      TextEditingController _email,
      TextEditingController _password,
      TextEditingController _name,
      TextEditingController _surname) {
    return ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          if (isLogin) {
            if (_formKey.currentState!.validate()) {
              final provider =
                  Provider.of<AuthProvider>(context, listen: false);
              provider.emailLogin(
                  email: _email.text.trim(), password: _password.text.trim());
            }
          } else {
            if (_formKey.currentState!.validate()) {
              final provider =
                  Provider.of<AuthProvider>(context, listen: false);
              provider.emailCreateAccount(
                  email: _email.text.trim(),
                  password: _password.text.trim(),
                  name: _name.text.trim(),
                  surname: _surname.text.trim());
            }
          }
        },
        child: isLogin ? const Text('Login') : const Text('Criar Conta'));
  }

  /// Elevated button to go to reset the user's password page
  ///
  /// @parameters
  /// TextEditingController _email The email to send the reset email
  Widget passwordResetButton(TextEditingController _email) {
    // TODO implement reset password page
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ResetPasswordPage()));
        },
        child: Text(
          'Esqueci minha senha',
          style: TextStyle(color: Colors.white),
        ));
  }

  /// TextButton that leads to the privacy policy page
  Widget privacyButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => EulaPage()));
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
