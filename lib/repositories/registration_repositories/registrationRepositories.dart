import 'dart:convert';
import "package:http/http.dart" as http;

class RegistrationRepositories {
  static const String root = "http://localhost:8001/";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";

  Future<List> getRegistrations() async {
    var uri = Uri.parse(root + "api/rest/registration/search");
    return [];
  }

  Future<void> createNewPatient(
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
      String? addressLine3,
      String? addressLine4,
      String? city,
      String? ethnicity,
      String? contactPreference,
      String? emergencyContactPhoneNumber,
      String? emergencyContactRelationship,
      String? emergencyContactName}) async {
    var uri = Uri.parse(root + "api/rest/v1/patient");
    final body;

    http.Response reponse = await http.post(uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
        encoding: Encoding.getByName("utf-8"),
        body: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "dateOfBirth": dateOfBirth,
          "middleName": middleName,
          "gender": gender,
          "religion": religion,
          "phoneNumber": phoneNumber,
          "email": email,
          "contactPreference": contactPreference,
          "ethnicity": ethnicity,
          "educationLevel": educationLevel,
          "countryCode": countryCode,
          "address": {
            "line1": addressLine1,
            "zipCode": zipCode,
            "city": city,
            "countryCode": countryCode
          },
          "emergencyContact": {
            "name": emergencyContactName,
            "phoneNumber": emergencyContactPhoneNumber,
            "relationship": emergencyContactRelationship
          },
          "aliveStatus": {"deceased": false}
        }));
    body = jsonDecode(reponse.body);
    print(body);
  }

  Future<List<dynamic>> getAppointment({String? token}) async {
    print('get Appointment token');
    print(token);
    //1 Uri
    var uri = Uri.parse(root + 'api/rest/v1/patient/search');

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

  Future<String> home({String? token}) async {
    var uri = Uri.parse(root + "api/rest/v1/home");
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

}
