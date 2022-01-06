import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  Widget nameField() {
    TextEditingController _name = TextEditingController();

    return TextFormField(
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
    );
  }

  Widget surnameField() {
    TextEditingController _surname = TextEditingController();

    return TextFormField(
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
    );
  }

  Widget nicknameField() {
    TextEditingController _nickname = TextEditingController();

    return TextFormField(
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
    );
  }

  Widget cepField() {
    TextEditingController _cep = TextEditingController();

    return TextFormField(
        controller: _cep,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'CEP',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        autocorrect: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira seu CEP';
          }
          return null;
        },
    );
  }

  Widget adressField() {
    TextEditingController _adress = TextEditingController();

    return TextFormField(
        controller: _adress,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Endereço',
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        autocorrect: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira seu endereço';
          }
          return null;
        },
    );
  }

  Widget adressComplementRow() {
    TextEditingController _number = TextEditingController();
    TextEditingController _complement = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextFormField(
              controller: _number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Número',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira seu número';
                }
                return null;
              },
            ),
          ),
        Expanded(
          child: TextFormField(
              controller: _complement,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Complemento (Opcional)',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira seu complemento';
                }
                return null;
              },
            ),
          ),
      ],
    );
  }

  Widget stateFieldRow() {
    return Row(
      children: [
        // State seleciton card
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.45,
            child: InkWell(
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: stateSelection());
                  }),
              child: Center(
                child: Text('Estado'),
              ),
            ),
          ),
        ),

        // City seleciton card
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.45,
            child: InkWell(
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: citySelection());
                  }),
              child: Center(
                child: Text('Cidade'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget stateSelection() {
    List<String> states = ['SP', 'RJ'];

    return ListView.builder(
        itemCount: states.length,
        itemBuilder: (BuildContext context, int state) => Card(
              child: SizedBox(
                height: 70,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(child: Text(states[state])),
                ),
              ),
            ));
  }

  Widget citySelection() {
    return Container();
  }

  Widget confirmButton() {
    return ElevatedButton(
      onPressed: () {
        print('Confirmar cadastro');
      },
      child: Text('Confirmar'),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Color.fromRGBO(45, 26, 71, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GenericAppBar(title: '', useTitle: false),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      nameField(),
                      surnameField(),
                      nicknameField(),
                      cepField(),
                      adressField(),
                      adressComplementRow(),
                    ],
                  )
              ),
              stateFieldRow(),
              confirmButton()
            ],
          ),
      ),
    );
  }
}
