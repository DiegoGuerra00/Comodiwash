import 'dart:async';
import 'dart:convert';
import 'package:comodiwash/models/car_list.dart';
import 'package:flutter/services.dart';

/// Load the car list from the assets json
Future<String> _loadCarAsset() async {
  return await rootBundle.loadString('assets/json/cars.json');
}

/// Get the cars from the json and saves each instance in a list
Future loadCars() async {
  String jsonCars = await _loadCarAsset();
  final jsonResponse = json.decode(jsonCars);
  CarList carList = CarList.fromJson(jsonResponse);

  return carList;
}
