import 'dart:convert';

import "package:http/http.dart" as http;

class AuthRepository {
  Future<void> signIn({String? username, String? password}) async {
    var uri = Uri.parse("http://localhost:8001/auth/login");
    var reponse = await http.post(uri,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json"
        },
        encoding: Encoding.getByName("utf-8"),
        body: {"username": username, "password": password});
  }

  Future<void> singout() async {}
}
