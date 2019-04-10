import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class ApiClient {
  const ApiClient();
  Future<dynamic> get(String url) async {
    final http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    }).timeout(const Duration(seconds: 10));
    if (response.statusCode >= 400) {
      throw _parseError(response.statusCode, response.body);
    }
    final dynamic jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  String _parseError(int code, String response) {
    dynamic message = response;
    if (response.contains('DOCTYPE html')) {
      return '$code: An error occurred';
    }
    try {
      final dynamic jsonResponse = json.decode(response);
      message = jsonResponse['error'] ?? jsonResponse;
      message = message['message'] ?? message;
    } catch (error) {}
    return '$code: $message';
  }
}
