import 'package:firebase_database/firebase_database.dart';

class DBRealtime {
  DBRealtime._();

  static final DBRealtime _instance = DBRealtime._();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  static FirebaseDatabase get() {
    return DBRealtime._instance._database;
  }
}
