import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;

class AppointmentRepository {
  static final String root = "${dotenv.get('API_URI')}/";
  static const String contentType = "application/json";
  static const String accept = "application/json";

  Future<http.Response?> searchAppointments(
      {String? searchParams,
      String? startDateTime,
      String? endDateTime,
      String? token,
      int? nextPage = 0,
      String? zoneId}) async {
    var startDateFormat = startDateTime ?? startDateTime?.split('.')[0];
    var endDateFormat = endDateTime ?? endDateTime?.split('.')[0];
    print(startDateTime);
    print(endDateTime);

    var uri = Uri.parse(root + 'api/rest/v1/appointment/search')
        .replace(queryParameters: <String, String>{
      'from': startDateFormat ?? '2020-01-01T00:00',
      'to': endDateFormat ?? '2024-01-01T00:00',
      'query': searchParams!,
      'zoneId': 'Africa/Lagos',
      "page": "$nextPage"
    });

    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": accept,
        "Content-Type": contentType,
        "Authorization": "Bearer $token",
      },
    );
    return response;
  }

//TODO: move to patientCubit
  Future<http.Response?> searchPatients(
      {String? searchParams, String? token, int? nextPage = 0}) async {
    var uri = Uri.parse(root + 'api/rest/v1/patient/search').replace(
        queryParameters: <String, String>{
          'query': searchParams!,
          "page": "$nextPage"
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

  Future<http.Response?> createAppointment(
      {String? token,
      String? patientId,
      String? medicalId,
      String? appointmentId,
      String? reasons,
      String? time,
      String? date,
      String? typeOfVisit}) async {
    var uri = Uri.parse(root + 'api/rest/v1/appointment')
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
            "dateTime": date,
            "minDuration": 30,
            "typeOfVisit": typeOfVisit,
            "reasonForVisit": reasons,
            "languagePreference": "en",
            'patientId': patientId,
            'medicalPersonnelId': medicalId
          }));

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> updateAppointment({
    String? id,
    String? languagePreference,
    String? typeOfVisit,
    String? reasonForVisit,
    String? dateTime,
    String? token,
  }) async {
    var uri = Uri.parse(root + 'api/rest/v1/appointment/$id')
        .replace(queryParameters: <String, String>{
      'zoneId': 'Africa/Lagos',
    });

    try {
      http.Response response = await http.patch(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": accept,
            "Authorization": "Bearer $token",
          },
          body: json.encode({
            "typeOfVisit": typeOfVisit,
            "reasonForVisit": reasonForVisit,
            "languagePreference": languagePreference,
            "dateTime": dateTime,
          }));

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> cancelAppointment({
    String? id,
    String? token,
  }) async {
    var uri = Uri.parse(root + 'api/rest/v1/appointment/$id');

    try {
      http.Response response = await http.delete(
        uri,
        headers: {
          "Accept": accept,
          "Authorization": "Bearer $token",
        },
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> searchRegistrations(
      {String? token, String? searchParams, int? nextPage = 0}) async {
    int pageNumber = 3;
    var uri =
        Uri.parse(root + 'api/rest/v1/registration/withAppointment/search')
            .replace(queryParameters: <String, String>{
      'from': '2020-01-01T00:00',
      'to': '2024-01-01T00:00',
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
