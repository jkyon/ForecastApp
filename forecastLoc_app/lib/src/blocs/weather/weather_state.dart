import 'package:equatable/equatable.dart';
import 'package:forecast_app/src/models/Forecast.dart';
import 'package:forecast_app/src/models/Weather.dart';
import 'package:forecast_app/src/models/local_time.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherEmptyState extends WeatherState {

  const WeatherEmptyState();
  @override
  String toString() => 'WeatherEmptyState';

  @override
  List<Object> get props => [];
}

class WeatherLoadingState extends WeatherState {

  const WeatherLoadingState();

  @override
  String toString() => 'WeatherLoadingState';

  @override
  List<Object> get props => [];
}

class WeatherCompleteState extends WeatherState {

  final Weather weather;
  final List<Forecast> fiveDaysForecast;
  final LocalTime localTime;

  const WeatherCompleteState(
      {@required this.weather, @required this.fiveDaysForecast, @required this.localTime,});

  @override
  String toString() => 'WeatherCompleteState';

  @override
  List<Object> get props => [weather, fiveDaysForecast, localTime];
}

class ErrorWeatherState extends WeatherState {

  const ErrorWeatherState();

  @override
  String toString() => 'ErrorWeatherState';

  @override
  List<Object> get props => [];
}
