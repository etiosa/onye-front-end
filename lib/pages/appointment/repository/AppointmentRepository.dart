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

  Future<http.Response?> createRegisteration(
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

      return response;
    } catch (e) {
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  Future<http.Response?> CreateAppointment(
      {String? token,
      String? patientID,
      String? medicalId,
      String? appointmentId,
      String? reasons,
      String? time,
      String? date,
      String? typofVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/appointment?zoneId=Africa/Lagos');

    try {
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "appointmentDateTime": date,
            "minDuration": 30,
            "typeOfVisit": typofVisit,
            "reasonForVisit": reasons,
            "languagePreference": "en",
            'patientId': patientID,
            'medicalPersonnelId': medicalId
          }));

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getAppointments({
    String? token,
  }) async {
    var uri = Uri.parse(root + 'api/rest/v1/appointment/search')
        .replace(queryParameters: <String, String>{
      'from': '2020-01-01T00:00',
      'to': '2024-01-01T00:00',
      'query': '',
      'zoneId': 'Africa/Lagos',
    });

    //1 Uri
    /*    var uri = Uri.parse(root +
        'api/rest/v1/appointment/search?from=2020-01-01T00:00&to=2024-01-01T00:00');
 */
    //2 http call
    http.Response reponse = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    var body = json.decode(reponse.body);
    var appointmentList = body['elements'];

    return appointmentList;
  }

  Future<List<dynamic>> getRegisterations(
      {String? token, String? searchParams}) async {
    //1 Uri

    var uri =
        Uri.parse(root + 'api/rest/v1/registration/withAppointment/search')
            .replace(queryParameters: <String, String>{
      'from': '2020-01-01T00:00',
      'to': '2024-01-01T00:00',
      'query': searchParams!,
      'zoneId': 'Africa/Lagos',
    });

    // var uri = Uri.parse(root +'api/rest/v1/registration/withAppointment/search?from=2020-01-01T00:00&to=2024-01-01T00:00');

    //2 http call
    http.Response reponse = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    var body = json.decode(reponse.body);
    print(body);
    var appointmentList = body['elements'];

    return appointmentList;
  }

  Future<bool> createAppointment(
      {String? token,
      String? patientID,
      String? medicalId,
      String? reasons,
      String? from,
      String? to,
      String? typofVisit}) async {
    var uri =
        Uri.parse(root + '/api/rest/v1/appointment?zoneId=Europe/Stockholm');
    var body;
    print('token');
    print(token);
    print(reasons);
    print(typofVisit);
    print(patientID);
    print(medicalId);

    try {
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "patientId": patientID,
            "appointmentId": null,
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
