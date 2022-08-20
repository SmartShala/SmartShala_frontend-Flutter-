import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/dash_testmodel.dart';
import '../constants/routes.dart';

Future<List<DashTestModel>> fetchTests(http.Client client) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access');
  Map<String, String> requestHeaders = {
    'Authorization': 'Bearer $token',
  };
  final response = await client.get(
      // Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      Uri.parse('$baseurl/test/?page=1&page_size=10'),
      headers: requestHeaders);
  log("fetchTests -> ${response.body}");
  // Use the compute function to run parseTests in a separate isolate.
  // log(response);
  return compute(parseTests, response.body);
}

// A function that converts a response body into a List<Photo>.
List<DashTestModel> parseTests(String responseBody) {
  final parsed =
      (jsonDecode(responseBody)['results']).cast<Map<String, dynamic>>();
  return parsed
      .map<DashTestModel>((json) => DashTestModel.fromJson(json))
      .toList();
}
