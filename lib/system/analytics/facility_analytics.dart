import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:onye_front_ened/system/analytics/events.dart';

class FacilityAnalytics {
  //create

  //setFacility data
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void createFacility(
      {required String userType,
      required String userId,
      required String time,
      required String facilityId}) async {
    await analytics.logEvent(
        name: FacilityEventType.create.toString(),
        parameters: {
          "userId": userId,
          "userType": userType,
          "time": time,
          "facilityId": facilityId
        });
  }

  void setFacilityData() {}
}
