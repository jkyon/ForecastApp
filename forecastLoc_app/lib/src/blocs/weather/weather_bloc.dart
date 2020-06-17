import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:forecast_app/src/repositories/exceptions/repository_exception.dart';
import 'package:forecast_app/src/repositories/repositories.dart';

import 'package:meta/meta.dart';

import './weather.dart';

class WeatherBloc extends Bloc<FetchWeatherEvent, WeatherState> {

  final WeatherRepository weatherRepository;

  final CityRepository cityRepository;

  final LocalTimeRepository localTimeRepository;

  WeatherBloc({@required this.cityRepository, @required this.weatherRepository, @required this.localTimeRepository});

  @override
  WeatherState get initialState => WeatherEmptyState();
  
  @override
  Stream<WeatherState> mapEventToState(
    FetchWeatherEvent event,
  ) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        var city;

        if(event.longitude != null && event.latitude != null){
           city = await cityRepository.loadCurrentCity(event.longitude, event.latitude);
        }
         
        var weather = await weatherRepository.loadCurrentWeather(
            cityName: event.cityName ?? city.city);
        var forecastList = await weatherRepository.loadForecast(
            weather.lon.toString(), weather.lat.toString());

        var localTime = await localTimeRepository.loadCurrentLocalTime(weather.lon.toString(), weather.lat.toString());
        yield WeatherCompleteState(
            weather: weather, fiveDaysForecast: forecastList, localTime: localTime);
      } on RepositoryException catch (e) {
        yield ErrorWeatherState(exception: e);
        rethrow;
      }
    }
  }
}
