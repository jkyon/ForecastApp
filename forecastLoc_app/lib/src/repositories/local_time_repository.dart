
import 'package:forecast_app/src/api/api_client.dart';
import 'package:forecast_app/src/models/models.dart';

class LocalTimeRepository {

  final ApiClient apiClient;

  LocalTimeRepository([this.apiClient = const ApiClient()]);

  Future<LocalTime> loadCurrentLocalTime(String longitude, String latitude) async {
    try{
      var url =
          'http://api.timezonedb.com/v2.1/get-time-zone?key=NTUYN19YG2MK&format=json&by=position&lat=$latitude&lng=$longitude';
      final dynamic response = await apiClient.get(url);

      return LocalTime.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}