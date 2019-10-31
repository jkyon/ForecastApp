import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeatherEvent extends WeatherEvent {
  final String longitude;
  final String latitude;
  final String cityName;
  
  const FetchWeatherEvent({this.cityName, this.longitude, this.latitude});

  @override
  List<Object> get props => [cityName,longitude, latitude];
}
