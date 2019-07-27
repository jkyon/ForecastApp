import 'package:forecast_app/src/api/api_client.dart';
import 'package:forecast_app/src/models/Forecast.dart';
import 'package:forecast_app/src/models/Weather.dart';

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
      final dynamic response = await this.apiClient.get(urlSelected);
      return Weather.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Forecast>> loadForecast(String longitude, String latitude) async {
    try {
      var url =
          'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&APPID=f24e6768f000a9f5f387d6b94a5b0411';
      final dynamic response = await this.apiClient.get(url);
      return Forecast.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
