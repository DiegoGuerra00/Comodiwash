import 'dart:convert';
import 'package:comodiwash/models/year_list.dart';
import 'package:flutter/services.dart';

/// Load the data of the years from the assets json
Future<String> _loadYearAsset() async {
  return await rootBundle.loadString('assets/json/years.json');
}

/// Decode the json data in a list
Future loadYear() async {
  String jsonYears = await _loadYearAsset();
  final jsonResponse = json.decode(jsonYears);
  YearList yearList = YearList.fromJson(jsonResponse);

  return yearList;
}
