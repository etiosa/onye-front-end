import 'dart:convert';
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";
class PatientRepositories {
  static final String root = "${dotenv.get('API_URI')}/";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";

  //TODO: use the patient model toJson
  //fromJSon
  //TODO: LOOK INTO BLOCK TO BLOCK COMMUNICATION
  //FOR LOGIN AND AUTHSTATE
  //CONNECTION
  //USE THAT FOR HOME AND LOGIN STATE
  Future<http.Response?> createNewPatient(
      {String? firstName,
      String? middleName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? religion,
      String? educationLevel,
      String? phoneNumber,
      String? email,
      String? countryCode,
      String? zipCode,
      String? addressLine1,
      String? addressLine2,
      String? city,
      String? ethnicity,
      String? contactPreference,
      String? emergencyContactPhoneNumber,
      String? emergencyContactRelationship,
      String? emergencyContactName,
      String? token}) async {
    var uri = Uri.parse(root + "api/rest/v1/patient");

    dynamic address;
    if (addressLine1 != null &&
        zipCode != null &&
        city != null &&
        countryCode != null) {
      address = {
        "line1": addressLine1,
        "line2": addressLine2,
        "zipCode": zipCode,
        "city": city,
        "countryCode": countryCode
      };
    }

    dynamic emergencyContact;
    if (emergencyContactName != null &&
        emergencyContactPhoneNumber != null &&
        emergencyContactRelationship != null) {
      emergencyContact = {
        "name": emergencyContactName,
        "phoneNumber": emergencyContactPhoneNumber,
        "relationship": emergencyContactRelationship
      };
    }

    try {
      http.Response response = await http.post(uri,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          encoding: Encoding.getByName("utf-8"),
          body: json.encode({
            "firstName": firstName,
            "middleName": middleName,
            "lastName": lastName,
            "dateOfBirth": dateOfBirth,
            "gender": gender,
            "religion": religion,
            "phoneNumber": phoneNumber,
            "email": email,
            "contactPreference": contactPreference,
            "ethnicity": ethnicity,
            "educationLevel": educationLevel,
            "countryCode": countryCode,
            "address": address,
            "emergencyContact": emergencyContact,
            "aliveStatus": {"deceased": false}
          }));
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getRegistrations(
      {String? token, String? queryParam}) async {
    //1 Uri
    var uri = Uri.parse(root +
        'api/rest/v1/registration/withAppointment/search?from=2020-01-01T00:00&to=2024-01-01T00:00&zoneId=Africa/Lagos');

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

  Future<String> home({String? token}) async {
    var uri = Uri.parse(root + "api/rest/v1/home");
    // ignore: prefer_typing_uninitialized_variables
    var body;
    try {
      http.Response response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Accept": accept,
        "Authorization": "Bearer $token",
      });
      body = jsonDecode(response.body);
      return body['token'];
    } catch (e) {
      return body['token'];
    }
  }

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

  

}
