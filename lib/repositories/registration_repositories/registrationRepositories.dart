import 'dart:convert';

import "package:http/http.dart" as http;

class RegistrationRepositories {
  static const String root = "http://localhost:8001/";
  static const String contentType = "application/json";
  static const String accept = "application/json";

  Future<List> getRegistrations() async {
    var uri = Uri.parse(root + "api/rest/registration/search");
    return [];
  }

  Future<void> createNewPatient(
      {String? firstName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? religion,
      String? educationLevel,
      String? phoneNumber,
      String? email,
      String? contactPreferences,
      String? countryCode,
      String? zipCode,
      String? addressLine1,
      String? addressLine2,
      String? city}) async {
   
    var uri = Uri.parse(root + "api/rest/v1/patient");
    final body =jsonEncode({
       "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "religion": religion,
      "phoneNumber": phoneNumber,
      "email": email,
      "contactPreference": contactPreferences,
      "aliveStatus": 1
    });


    http.Response reponse = await http.post(uri,
        headers: {"Content-Type": contentType, "Accept": accept,
         "Access-Control-Allow-Origin": "*"
        },
        body: body);
    //body = jsonDecode(reponse.body);
   // print(body);
  }
}
