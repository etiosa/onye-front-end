import 'dart:convert';

import "package:http/http.dart" as http;

class AppointmentRepository {
  static const String root = "http://localhost:8001/";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String accept = "application/json";

  Future<List<dynamic>> getAppointmentList() async {
    //1 Uri
/*      var uri = Uri.https("http://localhost:8001/" , 'api/rest/v1/appointment/search');
 */
    var uri = Uri.parse(root + 'api/rest/v1/appointment/search').replace(
        queryParameters: <String, String>{
          'from': '2020-01-01T00:00',
          'to': '2024-01-01T00:00',
          'query':'karl Jackson'
         
        });
    
    
    print(uri);

    //2 http call
    http.Response reponse = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );
    print(reponse.request);
    var body = json.decode(reponse.body);
    print(body);
    var appointmentList = body['elements'];

    return appointmentList;
  }
}
