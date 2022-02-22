import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  /// Save an value into shared preferences
  ///
  /// Value can be bool, int or string
  /// Key must be String
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print('Invalid Type');
    }
  }

  /// Get the stored value from the shared preferences, based on the key assigned to it
  ///
  /// If value searched don't exist return false
  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  /// Get the counter used for the timer on reset password page
  ///
  /// @param String key key used to identify the counter in SharedPreferences
  ///
  /// @return int counter or 300(seconds or 5 minutes) when value doesn't exist
  static Future<int> getTimerCounter(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int? obj = prefs.getInt(key);
    return obj?? 300;
  }

  static Future<int> getDateTime(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int? obj = prefs.getInt(key);
    return obj ?? 0;
  }

  /// Delete the data assigned to the key passed
  ///
  /// @param key String used to search in the shared preferences saved values
  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
