import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;

class DoctorRepository {
  static final String root = "${dotenv.get('API_URI')}/";
  static const String contentType = "application/json";
  static const String accept = "application/json";

  Future<http.Response?> searchDoctors(
      {String? searchParams, String? token, int? nextPage = 0}) async {
    Uri uri;
    if (searchParams != null && searchParams.isNotEmpty) {
      uri = Uri.parse(root + 'api/rest/v1/medicalPersonnel/search')
          .replace(queryParameters: <String, String>{
          'type': 'DOCTOR', 
        'query': searchParams,
        "page": "$nextPage"
      });
    } else {
      uri = Uri.parse(root + 'api/rest/v1/medicalPersonnel/search')
          .replace(queryParameters: <String, String>{
              'type': 'DOCTOR', 
        "page": "$nextPage"
      });
    }

    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": accept,
        "Content-Type": contentType,
        "Authorization": "Bearer $token",
      },
    );
    return response;
  }
}
