import 'package:equatable/equatable.dart';
import 'package:forecast_app/src/models/Forecast.dart';
import 'package:forecast_app/src/models/Weather.dart';
import 'package:forecast_app/src/models/local_time.dart';
import 'package:forecast_app/src/repositories/exceptions/exception_type.dart';
import 'package:forecast_app/src/repositories/exceptions/repository_exception.dart';
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

  const WeatherCompleteState({
    @required this.weather,
    @required this.fiveDaysForecast,
    @required this.localTime,
  });

  @override
  String toString() => 'WeatherCompleteState';

  @override
  List<Object> get props => [weather, fiveDaysForecast, localTime];
}

class ErrorWeatherState extends WeatherState {
  final String longitude;
  final String latitude;
  final String cityName;
  final RepositoryException exception;
  const ErrorWeatherState(
      {this.exception, this.longitude, this.latitude, this.cityName});

  @override
  String toString() {
    switch (exception.errorType) {
      case ExceptionType.SocketException:
        return 'Please check your internet connection! 😞';
      case ExceptionType.HttpException:
        return 'Could not find wheather information!  😥';
      case ExceptionType.FormatException:
        return 'Bad response format';
      case ExceptionType.ApiException:
        return 'Could not find wheather information!  😥';
      case ExceptionType.TypeError:
        return 'Bad response format 👎';
      default:
        return 'An error occured, please restar the app 😢';
    }
  }

  @override
  List<Object> get props => [exception];
}
