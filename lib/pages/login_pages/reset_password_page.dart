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

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    primary: Color.fromRGBO(45, 26, 71, 1),
    onPrimary: Colors.white,
    minimumSize: Size(300, 50),
  );

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

  Widget submitButton(String _email) {
    return ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final provider = Provider.of<AuthProvider>(context, listen: false);
            provider.emailResetPassword(email: _email);
          }
        },
        child: Text('Enviar'));
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
              submitButton(_emailController.text.trim())
            ],
          ),
        ),
      ),
    );
  }
}
