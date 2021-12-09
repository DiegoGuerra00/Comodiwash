import 'dart:ui';
import 'package:comodiwash/services/google_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            //bottom white widget
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Stack(children: <Widget>[
            Container(
                //top colored widget
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(31),
                    bottomRight: Radius.circular(31),
                  ),
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    Colors.purple.shade900,
                    Color.fromRGBO(45, 26, 71, 1),
                  ]),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 100),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/comodiwash_login_banner.png')
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                ElevatedButton.icon(
                  //Login with Google button
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    primary: Color.fromRGBO(64, 139, 255, 1), //background
                    onPrimary: Colors.white, //font
                    minimumSize: Size(300, 50),
                  ),
                  label: Text("Login com Google"),
                  icon: FaIcon(FontAwesomeIcons.google),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  //Login with Facebook button
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    primary: Color.fromRGBO(59, 89, 152, 1), //background
                    onPrimary: Colors.white, //font
                    minimumSize: Size(300, 50),
                  ),
                  label: Text("Login com Facebook"),
                  icon: FaIcon(FontAwesomeIcons.facebook),
                  onPressed: () => print("Apertado Face"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
              ],
            ),
          ])),
    );
  }
}
