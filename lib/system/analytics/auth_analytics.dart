import 'package:firebase_analytics/firebase_analytics.dart';

class AuthAnalytics {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  AuthAnalytics();

  Future<void> login({
    required String authState,
    required String authMethod,
    required String userId,
  }) async {
    await analytics.setUserId(id: userId);
    await analytics.logLogin(loginMethod: authMethod);
    await analytics.setUserProperty(name: "auth_state", value: authState);
  }

  Future<void> logout({
    required String authState,
    required String userId,
    required String authMethod,
  }) async {
    await analytics.setUserId(id: userId);
    await analytics.logLogin(loginMethod: authMethod);
    await analytics.setUserProperty(name: "auth_state", value: authState);
  }

  Future<void> setUserLog(
      {required String firstName,
      required String lastName,
      required String userType,
      required String hospitalId,
      required String hospital}) async {
    await analytics.setUserProperty(name: "user_type", value: userType);
    await analytics.setUserProperty(name: "hospital_Id", value: hospitalId);
    await analytics.setUserProperty(name: "first_name", value: firstName);
    await analytics.setUserProperty(name: "last_name", value: lastName);
    await analytics.setUserProperty(name: "hospital", value: hospital);
  }

  void createNewUser() {}
}
