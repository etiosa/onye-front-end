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
    final body;

    http.Response reponse = await http.post(uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName("utf-8"),
        body: json.encode({
          "firstName": "lasr",
          "lastName": "first",
          "dateOfBirth": "1992-04-27",
          "gender": "MALE",
          "religion": "None",
          "phoneNumber": "111-22-1111",
          "email": "test@gmail.com",
          "contactPreference": "PHONE",
          "countryCode": "UNDEFINED",
          "aliveStatus": {"deceased": false}
        }));
    body = jsonDecode(reponse.body);
  }

  Future<void> getFormDropDown() async {
    var uri = Uri.parse(root + "api/rest/v1/patient/formAlternatives");
    final body;
    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    final mapToOprions = Map.castFrom(json.decode(response.body));

    return;
  }

  Future<List<dynamic>> getAppointment() async {
    //1 Uri
    var uri = Uri.parse(root + 'api/rest/v1/appointment/search');

    //2 http call
    http.Response reponse = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
    var body = json.decode(reponse.body);
    var appointmentList = body['elements'];
    
    return appointmentList;

  }
}
