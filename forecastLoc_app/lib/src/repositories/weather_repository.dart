import 'dart:io';

import 'package:forecast_app/src/api/api_client.dart';
import 'package:forecast_app/src/api/exceptions/api_exception.dart';
import 'package:forecast_app/src/models/Forecast.dart';
import 'package:forecast_app/src/models/Weather.dart';

import 'exceptions/exception_type.dart';
import 'exceptions/repository_exception.dart';

class WeatherRepository {
  final ApiClient apiClient;

  WeatherRepository([this.apiClient = const ApiClient()]);

  Future<Weather> loadCurrentWeather(
      {String longitude, String latitude, String cityName}) async {
    try {
      var url =
          'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&APPID=f24e6768f000a9f5f387d6b94a5b0411';
      var urlCity =
          'http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&APPID=f24e6768f000a9f5f387d6b94a5b0411';
      var urlSelected = cityName == null ? url : urlCity;
      final dynamic response = await apiClient.get(urlSelected);
      return Weather.fromJson(response);
    } on SocketException catch (soEx) {
      throw RepositoryException(
          errorType: ExceptionType.SocketException, message: soEx.message);
    } on HttpException catch (httpEx) {
      throw RepositoryException(
        errorType: ExceptionType.HttpException,
        message: httpEx.message,
      );
    } on FormatException catch (foEx) {
      throw RepositoryException(
          errorType: ExceptionType.FormatException, message: foEx.message);
    } on ApiException catch (apiEx) {
      throw RepositoryException(
          errorType: ExceptionType.ApiException,
          message: apiEx.message,
          code: apiEx.code.toString());
    } on TypeError catch (e) {
      throw RepositoryException(
          errorType: ExceptionType.TypeError,
          message: e.toString(),
          stackTrace: e.stackTrace);
    }
  }

  Future<List<Forecast>> loadForecast(String longitude, String latitude) async {
    try {
      var url =
          'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&APPID=f24e6768f000a9f5f387d6b94a5b0411';
      final dynamic response = await apiClient.get(url);

      return Forecast.fromJson(response);
    } on SocketException catch (soEx) {
      throw RepositoryException(
          errorType: ExceptionType.SocketException, message: soEx.message);
    } on HttpException catch (httpEx) {
      throw RepositoryException(
        errorType: ExceptionType.HttpException,
        message: httpEx.message,
      );
    } on FormatException catch (foEx) {
      throw RepositoryException(
          errorType: ExceptionType.FormatException, message: foEx.message);
    } on ApiException catch (apiEx) {
      throw RepositoryException(
          errorType: ExceptionType.ApiException,
          message: apiEx.message,
          code: apiEx.code.toString());
    } on TypeError catch (e) {
      throw RepositoryException(
          errorType: ExceptionType.TypeError,
          message: e.toString(),
          stackTrace: e.stackTrace);
    }
  }
}
