import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comodiwash/databases/db_firestore.dart';
import 'package:comodiwash/models/garage_car.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:fluttertoast/fluttertoast.dart';

class GarageRepository extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser!;
  List<GarageCar> _garageList = [];
  late FirebaseFirestore db;
  late AuthProvider auth;

  UnmodifiableListView<GarageCar> get garageList =>
      UnmodifiableListView(_garageList);

  GarageRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readGarage();
  }

  /// Starts a instance of firestore
  _startFirestore() {
    db = DBFirestore.get();
  }

  /// Get the data of the user garage from firestore db, and store each car instance the in the _garageList List
  _readGarage() async {
    if (_garageList.isEmpty) {
      final snapshot = await db.collection('users/${user.uid}/garage').get();

      snapshot.docs.forEach((doc) {
        String manufacturer = doc.get('manufacturer');
        String model = doc.get('model');
        String year = doc.get('year');
        String plate = doc.get('plate');
        String icon = doc.get('icon');
        String color = doc.get('color');
        _garageList.add(new GarageCar(
            manufacturer: manufacturer,
            model: model,
            year: year,
            icon: icon,
            licensePlate: plate,
            color: color));
        notifyListeners();
      });
    }
  }

  /// Save the new car in the firestore database
  /// 
  /// If the license plate already exists in database show Toast with error message
  /// If the car is sucessfully add to the database show toast with confirmation
  save(GarageCar newCar) async {
    final snapshot = await db.collection('users/${user.uid}/garage').get();
    bool isInDatabase = false;

    snapshot.docs.forEach((doc) {
      if (doc.get('plate') == newCar.licensePlate) {
        isInDatabase = !isInDatabase;
      }
    });

    if (!isInDatabase) {
      try {
        _garageList.add(newCar);
        await db
            .collection('users/${user.uid}/garage')
            .doc(newCar.licensePlate)
            .set({
          'manufacturer': newCar.manufacturer,
          'model': newCar.model,
          'year': newCar.year,
          'plate': newCar.licensePlate,
          'icon': newCar.icon,
          'color': newCar.color
        });
        Fluttertoast.showToast(
          msg: 'Carro Adicionado',
          toastLength: Toast.LENGTH_LONG,
        );
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Algo deu errado, tente novamente',
          toastLength: Toast.LENGTH_LONG,
        );
        throw("Error while saving new car\n$e");
      }
      
    } else {
      Fluttertoast.showToast(
        msg: 'Este carro já existe',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  /// Remove a car from firestore, using the license plate as key to identify
  remove(GarageCar car) async {
    try {
      await db
        .collection('users/${user.uid}/garage')
        .doc(car.licensePlate)
        .delete();
        _garageList.remove(car);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Algo deu errado, tente novamente',
          toastLength: Toast.LENGTH_LONG,
        );
        throw("Error while removing car\n$e");
    }
    
  }
}
