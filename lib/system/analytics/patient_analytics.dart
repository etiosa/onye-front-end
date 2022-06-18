import 'package:firebase_analytics/firebase_analytics.dart';

class PatientAnalytics {
//create
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void createPatient(
      {required String userId,
      required String userType,
      required String time,
      required String patientId}) async {
    await analytics.logEvent(name: 'add_patient', parameters: {
      "userId": userId,
      "userType": userType,
      "time": time,
      "patientId": patientId
    });
  }

  void editPatient(
      {required String userId,
      required String userType,
      required String time,
      required String patiendId}) async {
    await analytics.logEvent(name: 'edit_patient', parameters: {

      "userId": userId,
      "userType":userType,
      "time": time,
      "patiendId":patiendId 
    });
  }

  void setFacilityData() {}

//set facilityData

}
