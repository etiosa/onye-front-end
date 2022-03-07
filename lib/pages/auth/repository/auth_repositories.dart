import 'dart:convert';

import "package:http/http.dart" as http;

class AuthRepository {
  static const String root = "http://localhost:8001/";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";

  Future<http.Response?> signIn({String? username, String? password}) async {
    // ignore: prefer_typing_uninitialized_variables
    try {
      var uri = Uri.parse(root + "auth/login");
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": contentType,
            "Accept": accept,
          },
          encoding: Encoding.getByName("utf-8"),
          body: {"username": username, "password": password});
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> home({String? token}) async {
    var uri = Uri.parse(root + "api/rest/v1/home");
    dynamic body;
    try {
      http.Response response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Accept": accept,
        "Authorization": "Bearer $token",
      });

      return response;

    } catch (e) {
      return null;
    }
  }

  //grab the user data here as well.

  Future<dynamic> signout({String? token}) async {
    var uri = Uri.parse(root + "auth/logout");
    dynamic body;
    try {
      http.Response response = await http.post(uri, headers: {
        "Content-Type": "application/json",
        "Accept": accept,
        "Authorization": "Bearer $token",
      });
      body = jsonDecode(response.body);

      return body;
    } catch (e) {
      return body;
    }
  }
}
