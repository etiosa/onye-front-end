import 'dart:convert';
import "package:http/http.dart" as http;

//TODO:  Move the root url to environment variable

class DropDownRepositories {
  static const String root = "https://api.onyedap.com//";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";

  Future<Map<String, dynamic>> getFormDropDown() async {
    var uri = Uri.parse(root + "api/rest/v1/patient/formAlternatives");
    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );
    var body = json.decode(response.body);
    return body;
  }
}
