import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:forecast_app/src/repositories/repositories.dart';

import 'package:meta/meta.dart';

import './weather.dart';

class WeatherBloc extends Bloc<FetchWeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository});

  WeatherState get initialState => WeatherEmptyState();
  
  @override
  Stream<WeatherState> mapEventToState(
    FetchWeatherEvent event,
  ) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        var weather = await weatherRepository.loadCurrentWeather(
            longitude: event.longitude,
            latitude: event.latitude,
            cityName: event.cityName);
        var forecastList = await weatherRepository.loadForecast(
            weather.lon.toString(), weather.lat.toString());
        yield WeatherCompleteState(
            weather: weather, fiveDaysForecast: forecastList);
      } catch (e) {
        yield ErrorWeatherState();
      }
    }
  }
}