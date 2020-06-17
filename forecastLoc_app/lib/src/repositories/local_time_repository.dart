
import 'dart:io';

import 'package:forecast_app/src/api/api_client.dart';
import 'package:forecast_app/src/api/exceptions/api_exception.dart';
import 'package:forecast_app/src/models/models.dart';

import 'exceptions/exception_type.dart';
import 'exceptions/repository_exception.dart';

class LocalTimeRepository {

  final ApiClient apiClient;

  LocalTimeRepository([this.apiClient = const ApiClient()]);

  Future<LocalTime> loadCurrentLocalTime(String longitude, String latitude) async {
    try{
      var url =
          'http://api.timezonedb.com/v2.1/get-time-zone?key=NTUYN19YG2MK&format=json&by=position&lat=$latitude&lng=$longitude';
      final dynamic response = await apiClient.get(url);

      return LocalTime.fromJson(response);
   } on SocketException catch (soEx) {
      throw RepositoryException(
          errorType: ExceptionType.SocketException, 
          message: soEx.message);
    } on HttpException catch (httpEx) {
      throw RepositoryException(
        errorType: ExceptionType.HttpException,
        message: httpEx.message,
      );
    } on FormatException catch (foEx) {
      throw RepositoryException(
        errorType: ExceptionType.FormatException,
        message: foEx.message
      );
    } on ApiException catch (apiEx) {
      throw RepositoryException(
        errorType: ExceptionType.ApiException,
        message: apiEx.message, code: apiEx.code.toString()
      );
    } on TypeError catch (e) {
      throw RepositoryException(
        errorType: ExceptionType.TypeError,
        message: e.toString(), stackTrace: e.stackTrace
      );
    }
  }
}