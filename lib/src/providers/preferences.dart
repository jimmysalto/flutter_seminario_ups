import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _preferences = Preferences._internal();

  factory Preferences() {
    return _preferences;
  }

  Preferences._internal();
  SharedPreferences _sharedPreferences;

  initPreferences() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  get token {
    return _sharedPreferences.getString('token') ?? '';
  }

  set token(String token) {
    _sharedPreferences.setString('token', token);
  }
}
