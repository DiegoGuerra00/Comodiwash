import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:comodiwash/databases/db_firestore.dart';
import 'package:comodiwash/models/products.dart';
import 'package:flutter/material.dart';

class ProductsRepository extends ChangeNotifier {
  List<Products> _productsList = [];
  late FirebaseFirestore db;

  UnmodifiableListView<Products> get productsList =>
      UnmodifiableListView(_productsList);

  ProductsRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readProducts();
  }

  /// Starts a instance of the firestore db
  _startFirestore() async {
    db = DBFirestore.get();
  }

  /// Gets the products from the database and store each instance on the _productsList list
  _readProducts() async {
    if (_productsList.isEmpty) {
      final snapshot = await db.collection('store/products/products').get();

      snapshot.docs.forEach((doc) {
        String name = doc.get('name');
        String icon = doc.get('icon');
        String description = doc.get('description');
        int priceInt = doc.get('price');
        double _priceDouble = priceInt.toDouble();
        _productsList.add(new Products(
            icon: icon, name: name, description: description, price: _priceDouble));
        notifyListeners();
      });
    }
  }
}
