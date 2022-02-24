import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AuthSession {
  static Future<SharedPreferences> pref = SharedPreferences.getInstance();

  Future<bool> saveHomeToken({String? homeToken}) async {
    final SharedPreferences prefs = await pref;
    if (homeToken!.isEmpty) {
      print('home token is empty');
      return false;
    } else {
      prefs.setString('hometoken', homeToken);
      print("home token was saved");
      getHomeToken();
      return true;
    }
  }

  Future<String>? getHomeToken() async {
    final SharedPreferences prefs = await pref;
    final homeToken = prefs.getString('hometoken');
    print('get token from shared preference');
    print(homeToken);

    return homeToken!;
  }

  Future<void> removeHomeToken() async {
    final SharedPreferences prefs = await pref;

   /*  final token = getHomeToken();
    token.then((token) => 
      prefs.remove(token!)
    
    ); */
  }
}
