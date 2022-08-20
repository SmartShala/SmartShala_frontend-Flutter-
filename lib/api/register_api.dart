import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/register_model.dart';

class RegisterApi {
  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    String url = "http://parikshana.smartshala.live/api/user/";
    final response = await http.post(Uri.parse(url),
        body: json.encode(requestModel.toJson()),
        headers: {"Content-type": "application/json"});
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 400 || response.statusCode == 201) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      return RegisterResponseModel.fromJson({});
    }
  }
}
