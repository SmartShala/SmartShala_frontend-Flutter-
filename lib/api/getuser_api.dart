import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class GetUserApi {
  Future<UserModel> getUser(String accessToken) async {
    String url = "http://parikshana.smartshala.live/api/user/";
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      return UserModel.fromJson({});
    }
  }
}
