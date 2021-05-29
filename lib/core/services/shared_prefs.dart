import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';

class SharedPrefs {
  static SharedPrefs? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPrefs?> getInstance() async {
    _instance ??= SharedPrefs();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  bool? get getOnboarding => _preferences!.getBool(kOnboarding);

  set onboarding(bool value) => _preferences!.setBool(kOnboarding, value);
}

final sharedPrefs = SharedPrefs();
