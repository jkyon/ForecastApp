

import 'package:forecast_app/src/blocs/ThemeBloc.dart';
import 'package:forecast_app/src/blocs/WeatherBloc.dart';
import 'package:forecast_app/src/repositories/WeatherRepository.dart';
import 'package:kiwi/kiwi.dart';

void initKiwi(){
  Container().registerFactory((c) => WeatherRepository());
  Container().registerFactory((x) => WeatherBloc(weatherRepository: x.resolve()));
  Container().registerFactory((x) => ThemeBloc());
}