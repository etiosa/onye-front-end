import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:onye_front_ened/system/analytics/events.dart';

class PatientAnalytics {
//create
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void createPatient(
      {required String userId,
      required String userType,
      required String time,
      required String patientId}) async {
    await analytics.logEvent(
        name: PatientEventType.add_patient.toString(),
        parameters: {
          "userId": userId,
          "userType": userType,
          "time": time,
          "patientId": patientId
        });
  }

  void setFacilityData() {}

//set facilityData

}
