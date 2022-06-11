import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:onye_front_ened/system/analytics/events.dart';

class RegistrationAnalytics {
  //create

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void createRegistration(
      {required String userId,
      required String userType,
      required String time,
      required String registrationId}) async {
    await analytics.logEvent(
        name: RegistrationEventType.create_registration.toString(),
        parameters: {
          "userId": userId,
          "userType": userType,
          "time": time,
          "registrationId": registrationId
        });
    //RegistrationEventType
  }

  void setRegistrationData() {}
}
