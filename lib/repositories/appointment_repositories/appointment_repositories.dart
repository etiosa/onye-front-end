import 'dart:convert';

import "package:http/http.dart" as http;

class AppointmentRepository {
  static const String root = "http://localhost:8001/";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";

  Future<List<dynamic>> getAppointmentList() async {
    //1 Uri
    var uri = Uri(host: root, path: 'api/rest/v1/patient/search', queryParameters: {});

    //2 http call
    http.Response reponse = await http.get(
      uri,
    
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
   
    );
    var body = json.decode(reponse.body);
    print(body);
    var appointmentList = body['elements'];

    return appointmentList;
  }
}



