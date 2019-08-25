import 'package:equatable/equatable.dart';
import 'package:forecast_app/src/models/Forecast.dart';
import 'package:forecast_app/src/models/Weather.dart';
import 'package:forecast_app/src/models/local_time.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable {
  WeatherState([Iterable props]) : super(props);
}

class WeatherEmptyState extends WeatherState {
  @override
  String toString() => 'WeatherEmptyState';
}

class WeatherLoadingState extends WeatherState {
  @override
  String toString() => 'WeatherLoadingState';
}

class WeatherCompleteState extends WeatherState {
  final Weather weather;
  final List<Forecast> fiveDaysForecast;
  final LocalTime localTime;
  WeatherCompleteState(
      {@required this.weather, @required this.fiveDaysForecast, @required this.localTime,})
      : super([weather, fiveDaysForecast, localTime]);
  @override
  String toString() => 'WeatherCompleteState';
}

class ErrorWeatherState extends WeatherState {
  @override
  String toString() => 'ErrorWeatherState';
}
