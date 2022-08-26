import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/login_student_model.dart';

class LoginstudentApi {
  Future<LoginstudentResponseModel> login(
      LoginstudentRequestModel requestModel) async {
    String url = "http://parikshana.smartshala.live/api/login/";
    final response = await http.post(Uri.parse(url),
        body: json.encode(requestModel.toJson()),
        headers: {"Content-type": "application/json"});
    // User is registered and tokens received
    if (response.statusCode == 200) {
      return LoginstudentResponseModel.fromJson(json.decode(response.body));
      // Username or password is invalid
    } else if (response.statusCode == 401) {
      return LoginstudentResponseModel(access: "", refresh: "");
    } else {
      throw Exception(
          'Failed to load json data: Response Code -> ${response.statusCode}');
    }
  }
}
