import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _nameFormKey = GlobalKey<FormState>();
  final _surnameFormKey = GlobalKey<FormState>();
  final _nicknameFormKey = GlobalKey<FormState>();

  Widget nameField() {
    TextEditingController _name = TextEditingController();

    return Form(
      key: _nameFormKey,
      child: TextFormField(
        controller: _name,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nome',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        autocorrect: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira seu nome';
          }
          return null;
        },
      ),
    );
  }

  Widget surnameField() {
    TextEditingController _surname = TextEditingController();

    return Form(
      key: _surnameFormKey,
      child: TextFormField(
        controller: _surname,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Sobrenome',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        autocorrect: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira seu sobrenome';
          }
          return null;
        },
      ),
    );
  }

  Widget nicknameField() {
    TextEditingController _nickname = TextEditingController();

    return Form(
      key: _nicknameFormKey,
      child: TextFormField(
        controller: _nickname,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Apelido (opcional)',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        autocorrect: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira seu apelido';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: '', useTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            nameField(),
            surnameField(),
            nicknameField(),
          ],
        ),
      ),
    );
  }
}
