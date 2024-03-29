import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:onye_front_ened/system/analytics/events.dart';

class ClinicalNoteAnalytics {
//create
//edit
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void createClinicalNote(
      {required String userId,
      required String userType,
      required String time,
      required String clinicalNoteId}) async {
    await analytics.logEvent(
        name: 'add_clinical_note',
        parameters: {
          "userId": userId,
          "userType": userType,
          "time": time,
          "clinicalNoteId": clinicalNoteId
        });
  }

  void editClinicalNote(
      {required String userId,
      required String userType,
      required String time,
      required String clinicalNoteId}) async {
    await analytics.logEvent(
        name: 'edit_clinical_note',
        parameters: {
          "userId": userId,
          "userType": userType,
          "time": time,
          "clinicalNoteId": clinicalNoteId
        });
  }

  void setClinicalNoteData() {}
}
