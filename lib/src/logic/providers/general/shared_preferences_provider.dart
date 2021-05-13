import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider with ChangeNotifier {
  SharedPreferences prefs;
  Future<void> getInstance() async {
    prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }
}
