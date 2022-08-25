import 'dart:developer';
import '../constants/routes.dart';
import 'package:http/http.dart' as http;

class TestDeleteApi {
  static const deleteCode = 204;

  Future<int> delete(String accessToken, int testId) async {
    String url = "$baseurl/test/$testId/";
    final response = await http.delete(Uri.parse(url), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    log(response.body);
    log(response.statusCode.toString());
    return response.statusCode;
  }
}
