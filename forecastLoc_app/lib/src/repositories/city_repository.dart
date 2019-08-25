

import 'package:forecast_app/src/api/api_client.dart';
import 'package:forecast_app/src/models/models.dart';

class CityRepository {

  final ApiClient apiClient;

  CityRepository([this.apiClient = const ApiClient()]);

  Future<City> loadCurrentCity(String longitude, String latitude) async {
     try {
      var url =
          'http://geocode.xyz/$latitude,$longitude?json=1&auth=748190069602589531x3311';
      final dynamic response = await this.apiClient.get(url);
      return City.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}