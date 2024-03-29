import 'package:firebase_analytics/firebase_analytics.dart';

import 'events.dart';

//TODO:  I
class AppointmentAnalytics {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void createLog(
      {required String userId,
      required String appointmentId,
      required String timeCreation,
      required String firstName,
      required String lastName,
      required String userType}) async {
    setUserLog(
        firstName: firstName,
        lastName: lastName,
        userId: userId,
        userType: userType);
    logEevent(
       eventType: 'create_appointment',
        appointmentId: appointmentId,
        userId: userId,
        time: timeCreation,
        userType: userType);
  }

  void cancelLog(
      {required String userId,
      required String appointmentId,
      required String timeDeletion,
      required String firstName,
      required String lastName,
      required String userType}) async {
    setUserLog(
        firstName: firstName,
        lastName: lastName,
        userId: userId,
        userType: userType);
    logEevent(
      eventType: 'cancel_appointment',
        appointmentId: appointmentId,
        userId: userId,
        time: timeDeletion,
        userType: userType);
  }
  //loginedUser
  //medical user information

  void editLog(
      {required String userId,
      required String appointmentId,
      required String timeEdit,
      required String firstName,
      required String lastName,
      required String userType}) async {
    setUserLog(
        firstName: firstName,
        lastName: lastName,
        userId: userId,
        userType: userType);
    logEevent(
      eventType: 'edit_appointment',
        appointmentId: appointmentId,
        userId: userId,
        time: timeEdit,
        userType: userType);
  }

  void setUserLog(
      {required String firstName,
      required String lastName,
      required String userId,
      required String userType}) async {
    await analytics.setUserId(id: userId);
    await analytics.setUserProperty(name: "firstName", value: firstName);
    await analytics.setUserProperty(name: "lastName", value: lastName);
    await analytics.setUserProperty(name: "userType", value: userType);
  }

//TODO: move the logEvent to a separate file OR  to uility class
  void logEevent(
      {required String userId,
        required String eventType,
      required String userType,
      required String time,
      required String appointmentId}) async {
    await analytics.logEvent(name: eventType, parameters: {
      "userId": userId,
      "userType": userType,
      "time": time,
      "appointmentId": appointmentId
    });
  }
}
