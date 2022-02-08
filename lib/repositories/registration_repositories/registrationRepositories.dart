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
    final body ={
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "religion": religion,
      "phoneNumber": phoneNumber,
      "email": email,
      "contactPreference": contactPreferences,
      "aliveStatus": 1
    };

    http.Response reponse = await http.post(uri, headers: {
     
      "Accept":"application/json",
       "Content-Type": "application/json",
       
     
    }, 
       encoding: Encoding.getByName("utf-8"),
      body: json.encode({
          "firstName": "lasr",
          "lastName": "first",
          "dateOfBirth": "1992-04-27",
          "gender": "gender",
          "religion": "None",
          "phoneNumber": "111-22-1111",
          "email": "test@gmail.com",
          "contactPreference": "Phone",
          "aliveStatus": '1'
        })
       
       );
    //body = jsonDecode(reponse.body);
    // print(body);
  }
}
