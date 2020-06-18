import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeatherEvent extends WeatherEvent {
  final String longitude;
  final String latitude;
  final String cityName;
  final Completer completer;

  FetchWeatherEvent(
      {this.cityName, this.longitude, this.latitude, Completer completer})
      : completer = completer ?? Completer();

  @override
  List<Object> get props => [cityName, longitude, latitude, completer];
}
