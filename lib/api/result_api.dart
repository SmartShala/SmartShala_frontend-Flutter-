import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/dash_testmodel.dart';
import '../constants/routes.dart';
import '../models/resultmodel.dart';

Future<List<ResultModel>> fetchresults(
    http.Client client, final String testID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access');
  Map<String, String> requestHeaders = {
    'Authorization': 'Bearer $token',
  };
  final response = await client.get(
      // Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      Uri.parse('$baseurl/grader/$testID'),
      headers: requestHeaders);
  log("fetchresults -> ${response.body}");
  // Use the compute function to run parseTests in a separate isolate.
  // log(response);
  return compute(parseResults, response.body);
}

// A function that converts a response body into a List<Photo>.
List<ResultModel> parseResults(String responseBody) {
  final parsed =
      (jsonDecode(responseBody)['results']).cast<Map<String, dynamic>>();
  return parsed.map<ResultModel>((json) => ResultModel.fromJson(json)).toList();
}
