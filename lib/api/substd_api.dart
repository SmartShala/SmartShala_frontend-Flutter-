import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/substd_model.dart';
import '../constants/routes.dart';

class SubAndStdApi {
  Future<SubAndStdModel> getdata(String accessToken) async {
    String url = "$baseurl/test/form-data/";
    final response = await http.get(Uri.parse(url), headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $accessToken",
    });
    if (response.statusCode == 200) {
      return SubAndStdModel.fromJson(json.decode(response.body));
    } else {
      return SubAndStdModel.fromJson({});
    }
  }
}
