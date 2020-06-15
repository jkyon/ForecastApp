import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int id;

  final String main;

  final String description;

  final String icon;

  final int temp;

  final int humidity;

  final int tempMax;

  final int tempMin;

  final String country;

  final String cityName;

  final int cityId;

  final double lon;

  final double lat;

  Weather(
      {this.id,
      this.main,
      this.description,
      this.icon,
      this.temp,
      this.humidity,
      this.tempMax,
      this.tempMin,
      this.country,
      this.cityName,
      this.cityId,
      this.lon,
      this.lat});

  static Weather fromJson(dynamic json) {
    return Weather(
        id: json['weather'][0]['id'],
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon'],
        temp: (json['main']['temp']).toInt(),
        humidity: json['main']['humidity'],
        tempMax: (json['main']['temp_max']).toInt(),
        tempMin: (json['main']['temp_min']).toInt(),
        country: json['sys']['country'],
        cityName: json['name'],
        cityId: json['id'],
        lat: json['coord']['lat'],
        lon: json['coord']['lon']);
  }

  @override
  List<Object> get props => [
        id,
        main,
        description,
        icon,
        temp,
        humidity,
        tempMax,
        tempMin,
        country,
        cityName,
        cityId,
        lat,
        lon
      ];
}
