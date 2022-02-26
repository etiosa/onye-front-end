import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AuthSession {
  static Future<SharedPreferences> pref = SharedPreferences.getInstance();

  Future<bool> saveHomeToken({String? homeToken}) async {
    final SharedPreferences prefs = await pref;
    if (homeToken!.isEmpty) {
      return false;
    } else {
      prefs.setString('hometoken', homeToken);
      getHomeToken();
      return true;
    }
  }

  Future<String>? getHomeToken() async {
    final SharedPreferences prefs = await pref;
    final homeToken = prefs.getString('hometoken');
    if (homeToken == null) {
      return '';
    }

    return homeToken;
  }

  Future<bool> removeHomeToken() async {
    final SharedPreferences prefs = await pref;
    final bool = prefs.remove('hometoken');

    return bool;
  }
}
