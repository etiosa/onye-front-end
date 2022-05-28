import 'dart:convert';
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;

class EulaRepository{
  static final String root = "${dotenv.get('API_URI')}/";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";



  Future<http.Response?> getLicenseAgreement({String? token}) async {
    try {
      var uri = Uri.parse(root + "api/rest/v1/license");
      http.Response reponse = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Accept": accept,
        "Authorization": "Bearer $token"
      });
      return reponse;
    } catch (err) {
      return null;
    }
  }

    Future<http.Response?> acceptContract({String? userId, String? token}) async {
    try {
      var uri = Uri.parse(root + "api/rest/v1/license")
          .replace(queryParameters: <String, String>{"userId": "$userId"});

      http.Response reponse = await http.post(uri, headers: {
        "Content-Type": "application/json",
        "Accept": accept,
        "Authorization": "Bearer $token"
      });

      return reponse;
    } catch (err) {
      return null;
    }
  }

}

/* 


 */