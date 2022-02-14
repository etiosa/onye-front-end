import 'dart:convert';

import "package:http/http.dart" as http;

class AuthRepository {
  static const String root = "http://localhost:8001/";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";

  Future<bool> signIn({String? username, String? password}) async {
    final bool status;
    // ignore: prefer_typing_uninitialized_variables
    final body;
    try {
      var uri = Uri.parse(root + "auth/login");
      http.Response reponse = await http.post(uri,
          headers: {
            "Content-Type": contentType,
            "Accept": accept,
          },
          encoding: Encoding.getByName("utf-8"),
          body: {"username": username, "password": password});
      body = jsonDecode(reponse.body);
      status = body['success'];
      print(status);
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> home() async {
    var uri = Uri.parse(root + "api/rest/v1/home");
    final int statusCode;
    try {
      http.Response response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        "Accept": accept,
        "Access-Control-Allow-Origin": "*",
      });
      statusCode = response.statusCode;
      return statusCode;
    } catch (e) {
      return -1;
    }
  }

  //grab the user data here as well.

  Future<void> singout() async {}
}
