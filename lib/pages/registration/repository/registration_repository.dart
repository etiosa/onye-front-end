import 'dart:convert';

import "package:http/http.dart" as http;

class RegistrationRepository {
  static const String root = "https://api.onyedap.com/";
  static const String contentType = "application/json";
  static const String accept = "application/json";

  Future<List<dynamic>> searchPatients(
      {String? searchParams, String? token}) async {
    var uri = Uri.parse(root + 'api/rest/v1/patient/search')
        .replace(queryParameters: <String, String>{
      'query': searchParams!,
    });

    // http call
    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": accept,
        "Content-Type": contentType,
        "Authorization": "Bearer $token",
      },
    );

    var body = json.decode(response.body);
    var patientsList = body['elements'];

    return patientsList;
  }

  Future<List<dynamic>> searchDoctors(
      {String? searchParams, String? token}) async {
    var uri = Uri.parse(root + 'api/rest/v1/medicalPersonnel/search')
        .replace(queryParameters: <String, String>{
      'query': searchParams!,
    });

    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": accept,
        "Content-Type": contentType,
        "Authorization": "Bearer $token",
      },
    );

    var body = json.decode(response.body);
    var doctorsList = body['elements'];

    return doctorsList;
  }

  Future<http.Response?> createRegistration(
      {String? token,
        String? patientId,
        String? medicalId,
        String? appointmentId,
        String? reasons,
        String? typeOfVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/registration')
        .replace(queryParameters: <String, String>{
      'zoneId': 'Africa/Lagos',
    });

    try {
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "patientId": patientId,
            "appointmentId": appointmentId,
            "medicalPersonnelId": medicalId,
            "typeOfVisit": typeOfVisit,
            "reasonForVisit": reasons,
            "languagePreference": "en"
          }));

      return response;
    } catch (e) {
      return null;
    }
  }




  Future<http.Response?> getPatientClinicalNote(
      {String? token,
   
        String? id,
        String? typeOfVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/clinicalNote/')
        .replace(queryParameters: <String, String>{
          'zoneId': 'Africa/Lagos',
          'id': id!
          });

    try {
      http.Response response = await http.get(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> getPatientClinicalNotes(
      {String? token,
      String? patientId,
      String? medicalId,
      String? appointmentId,
      String? reasons,
      String? typeOfVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/registration')
        .replace(queryParameters: <String, String>{
      'zoneId': 'Africa/Lagos',
    });

    try {
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "patientId": patientId,
            "appointmentId": appointmentId,
            "medicalPersonnelId": medicalId,
            "typeOfVisit": typeOfVisit,
            "reasonForVisit": reasons,
            "languagePreference": "en"
          }));

      return response;
    } catch (e) {
      return null;
    }
  }



}








