import 'dart:convert';

import "package:http/http.dart" as http;

class AppointmentRepository {
  static const String root = "http://localhost:8001/";
  static const String contentType = "application/json";
  static const String accept = "application/json";

  Future<List<dynamic>> getAppointmentList(
      {String? searchParams,
      String? startDateTime,
      String? endDateTime,
      String? token,
      String? zoneId}) async {
    var uri = Uri.parse(root + 'api/rest/v1/appointment/search')
        .replace(queryParameters: <String, String>{
      'from': '2020-01-01T00:00',
      'to': '2024-01-01T00:00',
      'query': searchParams!,
      'zoneId': 'Africa/Lagos',
    });

    // http call
    http.Response reponse = await http.get(
      uri,
      headers: {
        "Accept": accept,
        "Content-Type": contentType,
        "Authorization": "Bearer $token",
      },
    );
    var body = json.decode(reponse.body);
    var appointmentList = body['elements'];
    print(appointmentList);

    return appointmentList;
  }

  Future<List<dynamic>> getPatientsList(
      {String? searchParams, String? token}) async {
    var uri = Uri.parse(root + 'api/rest/v1/patient/search')
        .replace(queryParameters: <String, String>{
      'query': searchParams!,
    });

    // http call
    http.Response reponse = await http.get(
      uri,
      headers: {
        "Accept": accept,
        "Content-Type": contentType,
        "Authorization": "Bearer $token",
      },
    );

    var body = json.decode(reponse.body);
    var patientsList = body['elements'];

    return patientsList;
  }

  Future<List<dynamic>> getDoctorList(
      {String? searchParams, String? token}) async {
    print(searchParams);
    var uri = Uri.parse(root + 'api/rest/v1/medicalPersonnel/search')
        .replace(queryParameters: <String, String>{
      'query': searchParams!,
    });

    // http call
    http.Response reponse = await http.get(
      uri,
      headers: {
        "Accept": accept,
        "Content-Type": contentType,
        "Authorization": "Bearer $token",
      },
    );

    var body = json.decode(reponse.body);
    var doctorsList = body['elements'];

    return doctorsList;
  }

  Future<bool> createAppointmeent(
      {String? token,
      String? patientID,
      String? medicalId,
      String? appointmentId,
      String? dateTime,
      String? reasons,
      String? typofVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/appointment?zoneId=Africa/Lagos ');

    var body;

    try {
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "appointmentDateTime": "2022-02-20T11:30:00.000Z",
            "minDuration": 30,
            "typeOfVisit": reasons,
            "reasonForVisit": typofVisit,
            "languagePreference": "en"
          }));

      print(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createRegisteration(
      {String? token,
      String? patientID,
      String? medicalId,
      String? appointmentId,
      String? reasons,
      String? typofVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/registration?zoneId=Africa/Lagos');
    var body;

    try {
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "patientId": patientID,
            "appointmentId": appointmentId,
            "medicalPersonnelId": medicalId,
            "typeOfVisit": typofVisit,
            "reasonForVisit": reasons,
            "languagePreference": "en"
          }));

      print(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
}
