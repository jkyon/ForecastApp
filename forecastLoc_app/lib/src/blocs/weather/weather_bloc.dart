import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:forecast_app/src/repositories/exceptions/repository_exception.dart';
import 'package:forecast_app/src/repositories/repositories.dart';

import 'package:meta/meta.dart';

import './weather.dart';

class WeatherBloc extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  final CityRepository cityRepository;

  final LocalTimeRepository localTimeRepository;

  WeatherBloc(
      {@required this.cityRepository,
      @required this.weatherRepository,
      @required this.localTimeRepository})
      : super(WeatherEmptyState());

  Future<void> getWeather(
      {String longitude,
      String latitude,
      String cityName,
      Completer completer}) async {
    try {
      emit(WeatherLoadingState());
      await _getData(longitude, latitude, cityName, completer);
    } on RepositoryException catch (e) {
      if (completer != null) completer.complete();
      emit(ErrorWeatherState(
          exception: e,
          latitude: latitude ?? '0.0',
          longitude: longitude ?? '0.0'));
    }
  }

  Future<void> _getData(String longitude, String latitude, String cityName,
      Completer completer) async {
    var city;

    if (longitude != null && latitude != null) {
      city = await cityRepository.loadCurrentCity(longitude, latitude);
    }

    var weather = await weatherRepository.loadCurrentWeather(
        cityName: cityName ?? city.city);
    var forecastList = await weatherRepository.loadForecast(
        weather.lon.toString(), weather.lat.toString());

    var localTime = await localTimeRepository.loadCurrentLocalTime(
        weather.lon.toString(), weather.lat.toString());

    if (completer != null) completer.complete();

    emit(WeatherCompleteState(
        weather: weather,
        fiveDaysForecast: forecastList,
        localTime: localTime));
  }
}
