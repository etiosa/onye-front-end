import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

class ClinicalNoteRepository {
  static final String root = "${dotenv.get('API_URI')}/";
  static const String contentType = "application/json";
  static const String accept = "application/json";




  Future<http.Response?> createClinicalNote(
      {String? token,
      String? patientId,
      String? medicalId,
      String? title,
      String? note,
      String? registerationId,
      String? clincialNoteType}) async {
    var uri = Uri.parse(root + 'api/rest/v1/clinicalNote')
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
            "type": clincialNoteType,
            "patientId": patientId,
            "medicalPersonnelId": medicalId,
            "title": title,
            "text": note,
            "registrationId": registerationId
          }));

      return response;
    } catch (e) {
      return null;
    }
  }


  Future<http.Response?> getPatientClinicalNote(
      {String? token, String? id, String? typeOfVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/clinicalNote/$id');

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

  Future<http.Response?> updateClinicalNote({
    String? id,
    String? type,
    String? title,
    String? noteText,
    String? token,
  }) async {
    var uri = Uri.parse(root + 'api/rest/v1/clinicalNote/$id');

    try {
      http.Response response = await http.patch(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({"type": type, "title": title, "text": noteText}));
      return response;
    } catch (e) {
      return null;
    }
  }
}
