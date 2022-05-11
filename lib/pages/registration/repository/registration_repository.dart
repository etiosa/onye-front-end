import 'dart:convert';
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;

class RegistrationRepository {
  static final String root = "${dotenv.get('API_URI')}/";
  static const String contentType = "application/json";
  static const String accept = "application/json";

  Future<http.Response?> searchPatients(
      {String? searchParams, String? token, int? nextPage = 0}) async {
    print(nextPage);
    var uri = Uri.parse(root + 'api/rest/v1/patient/search').replace(
        queryParameters: <String, String>{
          'query': searchParams!,
          "page":  "$nextPage"
        });

    // http call
    try {
      http.Response response = await http.get(
        uri,
        headers: {
          "Accept": accept,
          "Content-Type": contentType,
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (ee) {
      return null;
    }
  }

  Future<http.Response?> getPatientClinicalNote(
      {String? token, String? id, String? typeOfVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/clinicalNote/').replace(
        queryParameters: <String, String>{'zoneId': 'Africa/Lagos', 'id': id!});

    try {
      http.Response response = await http.get(
        uri,
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

  Future<http.Response?> createRegistration(
      {String? token,
      String? patientId,
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
            "typeOfVisit": typeOfVisit,
            "reasonForVisit": reasons,
            "languagePreference": "en"
          }));

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> searchRegistrations(
      {String? token,
      String? searchParams,
      int? nextPage = 0,
      String? endDateTime,
      String? startDateTime}) async {
    var startDateFormat = startDateTime?.split('.')[0];
    var endDateFormat = endDateTime?.split('.')[0];
    var uri =
        Uri.parse(root + 'api/rest/v1/registration/withAppointment/search')
            .replace(queryParameters: <String, String>{
      'from': startDateFormat ?? '2020-01-01T00:00',
      'to': endDateFormat ?? '2024-01-01T00:00',
      'query': searchParams ?? '',
      'zoneId': 'Africa/Lagos',
      "page": "$nextPage"
    });

    try {
      http.Response response = await http.get(
        uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (err) {
      return null;
    }
  }
}
