import 'dart:async';
import 'dart:convert';
import 'package:comodiwash/models/manufacturer_list.dart';
import 'package:flutter/services.dart';

/// Load the manufacturers data from the json in the assets
Future<String> _loadManudacturerAsset() async {
  return await rootBundle.loadString('assets/json/manufacturers.json');
}

/// Save the data of the manufactures in a list
Future loadManufacturer() async {
  String jsonManufacturers = await _loadManudacturerAsset();
  final jsonResponse = json.decode(jsonManufacturers);
  ManufacturerList manufacturerList = ManufacturerList.fromJson(jsonResponse);

  return manufacturerList;
}
