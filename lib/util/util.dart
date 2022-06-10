import 'package:jwt_decode/jwt_decode.dart';
import 'package:onye_front_ened/session/auth_session.dart';

class Util {
  static final AuthSession _authSession = AuthSession();

  static bool hasTokenExpired() {
    bool isExpired = false;
    _authSession.getHomeToken()!.then((String value) {
      print(value);
      if(value.isNotEmpty || value != ''){
        isExpired = Jwt.isExpired(value);
        return isExpired;
      }
    
    });
    return isExpired;
  }
}
