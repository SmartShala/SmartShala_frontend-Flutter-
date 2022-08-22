import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../constants/routes.dart';

class TestCreationApi {
  dynamic create(
      String jsonString, int testId, String accessToken) async {
    String url = "$baseurl/test/$testId/questions/";
    final response =
        await http.post(Uri.parse(url), body: jsonString, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    log("Request -> $jsonString");
    log("Response -> ${response.body.toString()}");
    log("Response code -> ${response.statusCode.toString()}");
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      return {};
    }
  }
}
