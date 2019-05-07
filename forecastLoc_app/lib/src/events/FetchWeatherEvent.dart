import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class FetchWeatherEvent extends WeatherEvent {
  final String longitude;
  final String latitude;
  final String cityName;
  FetchWeatherEvent({this.cityName, this.longitude, this.latitude})
      : super([cityName,longitude, latitude]);
}
