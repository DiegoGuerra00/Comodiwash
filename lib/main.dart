import 'package:comodiwash/comodiwash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ComodiWash());
}
