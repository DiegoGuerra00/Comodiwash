import 'package:comodiwash/pages/login_pages/reset_password_page.dart';
import 'package:comodiwash/pages/user_profile_pages/support_pages/eula_page.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:flutter/material.dart';
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    primary: Color.fromRGBO(45, 26, 71, 1),
    onPrimary: Colors.white,
    minimumSize: Size(130, 50),
  );

  /// Returns InputDecoration for the TextFormFields.
  ///
  /// @parameters
  /// String hintText String containing the text to be used as hint for that specific textfield
  /// Icon prefixIcon Icon to be used in the textfield
  InputDecoration formDecoration(String hintText, Icon prefixIcon) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      border: OutlineInputBorder(),
      hintText: hintText,
      fillColor: Colors.white,
      prefixIcon: prefixIcon,
      prefixIconColor: Color.fromRGBO(45, 26, 71, 1),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(45, 26, 71, 1)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  /// SizedBox used only for spacing porposes
  Widget genericSizedBox() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.015,
    );
  }

  /// Create a Stack with gradient for the purple background and the column with the buttons
  Widget buildBody() {
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
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              // Logo
              bannerLogo(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              // Background of the textfields
              Stack(
                children: [
                  // White background in the login textfields
                  Positioned(
                    bottom: isLogin
                        ? MediaQuery.of(context).size.height * 0.28
                        : MediaQuery.of(context).size.height * 0.055,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.97,
                        height: isLogin
                            ? MediaQuery.of(context).size.height * 0.25
                            : MediaQuery.of(context).size.height * 0.48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  isLogin ? Radius.zero : Radius.circular(20),
                              topRight:
                                  isLogin ? Radius.circular(20) : Radius.zero,
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Colors.white)),
                  ),

                  // White background on Login button
                  isLogin
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.48,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white))
                      : Container(),

                  // White background on Create Account button
                  if (isLogin)
                    Container()
                  else
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.00001,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.48,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white)),
                    ),

                  // Login textfields
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 8,
                        ),
                        child: Form(
                          key: _formKey,
                          child: emailLoginField(),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      isLogin ? googleLoginButton() : Container(),
                      // TODO reenable apple login button
                      isLogin
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01)
                          : Container(),
                      isLogin ? appleLoginButton() : Container(),
                      isLogin
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10)
                          : SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              privacyButton(),
            ],
          ),
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

  /// Elevated button for login with apple
  /// TODO add login with apple
  Widget appleLoginButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        primary: Color.fromRGBO(67, 67, 69, 1), //background
        onPrimary: Colors.white, //font
        minimumSize: Size(300, 50),
      ),
      label: Text("Login com Apple",
          style: TextStyle(color: Color.fromRGBO(225, 225, 214, 1))),
      icon: FaIcon(FontAwesomeIcons.apple,
          color: Color.fromRGBO(225, 225, 214, 1)),
      onPressed: () => print("Apertado Apple"),
    );
  }

  /// Button to switch between login and sign in fiels
  Widget loginOptionsRow() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
        ),
        TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text('Login',
                style: TextStyle(
                    fontSize: 16,
                    color: isLogin ? Colors.black : Colors.white))),
        SizedBox(width: MediaQuery.of(context).size.width * 0.29),
        TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text('Criar Conta',
                style: TextStyle(
                    fontSize: 16,
                    color: !isLogin ? Colors.black : Colors.white))),
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

    @override
    void dispose() {
      _email.dispose();
      _password.dispose();
      _confirmPassword.dispose();
      _name.dispose();
      _surname.dispose();
    }

    return Column(
      children: [
        loginOptionsRow(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        emailField(_email),
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
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            passwordResetButton(_email),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
            ),
            loginConfirmButton(_email, _password, _name, _surname),
          ],
        )
      ],
    );
  }

  /// TextForm field to get user email.
  ///
  ///@parameters
  ///TextEditingController _email TextEditingController to store the input from the user
  ///
  /// Is used in login and sign in
  Widget emailField(TextEditingController _email) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: Stack(children: [
        TextFormField(
          controller: _email,
          decoration:
              formDecoration('E-mail*', Icon(Icons.email, color: Colors.grey)),
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
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
        ),
      ]),
    );
  }

  /// TextForm field to get user password.
  ///
  ///@parameters
  ///TextEditingController _password TextEditingController to store the input from the user
  ///
  /// Is used in login and sign in
  Widget passwordField(TextEditingController _password) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: TextFormField(
        controller: _password,
        decoration:
            formDecoration('Senha*', Icon(Icons.password, color: Colors.grey)),
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
          if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])$')
                  .hasMatch(value) &&
              !isLogin) {
            return 'Sua senha deve possuir pelo menos um caractere maiúsculo, \num minúsculo e um número';
          }
          return null;
        },
      ),
    );
  }

  /// TextForm field to get confirm the password.
  ///
  /// Used only on sign up
  Widget confirmPasswordField(
      TextEditingController _confirmPassword, TextEditingController _password) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: TextFormField(
        controller: _confirmPassword,
        decoration: formDecoration(
            'Confirme sua senha*', Icon(Icons.password, color: Colors.grey)),
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
          if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])$')
                  .hasMatch(value) &&
              !isLogin) {
            return 'Sua senha deve possuir pelo menos um caractere maiúsculo, \num minúsculo e um número';
          }
          return null;
        },
      ),
    );
  }

  /// TextField to get user name.
  ///
  ///@parameters
  ///TextEditingController _name TextEditingController to store the input from the user
  ///
  /// Used only on sign up
  Widget nameField(TextEditingController _name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: TextFormField(
        controller: _name,
        decoration: formDecoration(
            'Nome*', Icon(Icons.account_circle, color: Colors.grey)),
        obscureText: false,
        autocorrect: false,
        enableSuggestions: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  /// TextField to get user surname.
  ///
  ///@parameters
  ///TextEditingController _surmane TextEditingController to store the input from the user
  ///
  /// User only on sign in
  Widget surnameField(TextEditingController _surname) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: TextFormField(
        controller: _surname,
        decoration: formDecoration(
            'Sobrenome*', Icon(Icons.account_circle, color: Colors.grey)),
        obscureText: false,
        autocorrect: false,
        enableSuggestions: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
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
        child: isLogin
            ? const Text(
                'Login',
                style: TextStyle(fontSize: 16),
              )
            : const Text(
                'Criar Conta',
                style: TextStyle(fontSize: 16),
              ));
  }

  /// Elevated button to go to reset the user's password page
  ///
  /// @parameters
  /// TextEditingController _email The email to send the reset email
  Widget passwordResetButton(TextEditingController _email) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ResetPasswordPage()));
        },
        child: Text(
          'Esqueci minha senha',
          style: TextStyle(color: Colors.grey),
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
        body: SingleChildScrollView(child: buildBody()));
  }
}
