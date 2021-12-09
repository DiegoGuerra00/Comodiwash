import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:comodiwash/databases/db_firestore.dart';
import 'package:comodiwash/models/services.dart';
import 'package:flutter/material.dart';

class ServicesRepository extends ChangeNotifier {
  List<Services> _servicesList = [];
  late FirebaseFirestore db;

  UnmodifiableListView<Services> get servicesList =>
      UnmodifiableListView(_servicesList);

  ServicesRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readServices();
  }

  /// Starts a instance of the firestore database
  _startFirestore() async {
    db = DBFirestore.get();
  }

  /// Gets the services info from the database and store each instance of service in the _servicesList list 
  _readServices() async {
    if (_servicesList.isEmpty) {
      final snapshot = await db.collection('/store/services/services').get();

      snapshot.docs.forEach((doc) {
        String name = doc.get('name');
        String icon = doc.get('icon');
        String description = doc.get('description');
        double price = doc.get('price');
        _servicesList.add(new Services(icon: icon, name: name, description: description, price: price));
        notifyListeners();
      });
    }
  }
}
