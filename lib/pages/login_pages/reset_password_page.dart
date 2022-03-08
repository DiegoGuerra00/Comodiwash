import 'dart:async';

import 'package:comodiwash/services/auth_service.dart';
import 'package:comodiwash/services/themes/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int _timerCounter = 30;
  late Timer _timer;
  int _lastDateTime = 0;

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getTimerState());
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

  /// Function used to start the timer when the user clicks on the submmit button
  void _startTimer() async {
    getTimerState();
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

  void getTimerState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _timerCounter = prefs.getInt('timerCounter') ?? 30; //TODO set 300 seconds
    _lastDateTime = prefs.getInt('timeStamp') ?? 0;
    if (_lastDateTime != 0) {
      DateTime before = DateTime.fromMillisecondsSinceEpoch(_lastDateTime);
      DateTime now = DateTime.now();
      Duration timeDifference = now.difference(before);
      int timeDifferenceSeconds = timeDifference.inSeconds;

      _timerCounter = _timerCounter - timeDifferenceSeconds;

      if (_timerCounter > 0) {
        setState(() {
          canSendEmail = false;
        });
      }
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_timerCounter > 0) {
          setState(() {
            _timerCounter--;
            print('Timer:' + _timerCounter.toString());
          });
        } else {
          setState(() {
            canSendEmail = true;
          });
          StorageManager.saveData('canSendEmail', true);
          _timer.cancel();
          StorageManager.deleteData('timerCounter');
          StorageManager.deleteData('timeStamp');
        }
      });
    }
  }

  /// Sends the password reset email and then awaits 5 minutes to enable the send button again
  Future resetPassword() async {
    setState(() {
      canSendEmail = false;
      StorageManager.saveData('canSendEmail', false);
    });

    try {
      if (_formKey.currentState!.validate()) {
        final provider = Provider.of<AuthProvider>(context, listen: false);
        // provider.emailResetPassword(email: _emailController.text.trim());
        _startTimer();
        spamCount++;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        StorageManager.saveData('timerCounter', _timerCounter);
        int timeStamp = DateTime.now().millisecondsSinceEpoch;
        StorageManager.saveData('timeStamp', timeStamp);
        StorageManager.saveData('canSendEmail', canSendEmail);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
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
                submitButton(),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
