import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:forecast_app/src/api/exceptions/api_exception.dart';
import 'package:http/http.dart' as http;

class ApiClient {

  const ApiClient();
  
  Future<dynamic> get(String url) async {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    }).timeout(const Duration(seconds: 10));
    if (response.statusCode >= 400) {
      throw _parseError(response.statusCode, response.body);
    }
    final dynamic jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  ApiException _parseError(int code, String response) {
    dynamic message = response;
    if (response.contains('DOCTYPE html')) {
      return ApiException(message:'An error occurred', code: code);
    }
    try {
      final dynamic jsonResponse = json.decode(response);
      message = jsonResponse['error'] ?? jsonResponse;
      message = message['message'] ?? message;
    } catch (error) {
      return ApiException(message: error.toString(), code: code);
    }
    return ApiException(message: message, code: code);
  }
}
