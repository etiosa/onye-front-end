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
        "Access-Control-Allow-Origin": "*",
      },
    );
    var body = json.decode(reponse.body);
    var appointmentList = body['elements'];

    return appointmentList;
  }

  Future<List<dynamic>> getPatientsList({String? searchParams}) async {
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
        "Access-Control-Allow-Origin": "*",
      },
    );

    var body = json.decode(reponse.body);
    var patientsList = body['elements'];

    return patientsList;
  }

  Future<List<dynamic>> getDoctorList({String? searchParams}) async {
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
        "Access-Control-Allow-Origin": "*",
      },
    );
   
    var body = json.decode(reponse.body);
     print(body);
    var doctorsList = body['elements'];

    return doctorsList;
  }
}
