import 'dart:convert';
import 'package:http/http.dart' as http;

/// General utility functions to handle api calls
/// NOTE: Errors are not handled, handle in caller

Future<Map<String, dynamic>> getFromApi({required String apiUrl}) async {
  /// Issue a get request
  final response = await http.get(Uri.parse(apiUrl));
  return jsonDecode(response.body);
}

Future<http.Response> postToApi(Map<String, dynamic> json, {required String apiUrl}) async {
  /// Send a json map structure to the given api as POST and return the
  /// response; can throw exceptions
  final response = await http.post(Uri.parse(apiUrl),
      body: jsonEncode(json),
      headers: {"Content-type": "application/json"});

  return response;
}
