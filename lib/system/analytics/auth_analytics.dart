import 'package:firebase_analytics/firebase_analytics.dart';

class AuthAnalytics {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  AuthAnalytics();

  void login({
    required String authState,
    required String authMethod,
    required String userId,
  }) async {
    await analytics.setUserId(id: userId);
    await analytics.logLogin(loginMethod: authMethod);
    await analytics.setUserProperty(name: "authState", value: authState);
  }

  void logout({
    required String authState,
    required String userId,
    required String authMethod,
  }) async {
    await analytics.setUserId(id: userId);
    await analytics.logLogin(loginMethod: authMethod);
    await analytics.setUserProperty(name: "authState", value: authState);
  }

  void setUserLog(
      {required String firstName,
      required String lastName,
      required String userType,
      required String hospitalId,
      required String hospital}) async {
    await analytics.setUserProperty(name: "userType", value: userType);
    await analytics.setUserProperty(name: "hospitalId", value: hospitalId);

    await analytics.setUserProperty(name: "firstName", value: firstName);
    await analytics.setUserProperty(name: "lastName", value: lastName);
    await analytics.setUserProperty(name: "userType", value: userType);
    await analytics.setUserProperty(name: "hospital", value: hospital);
  }

  void createNewUser() {}
}
