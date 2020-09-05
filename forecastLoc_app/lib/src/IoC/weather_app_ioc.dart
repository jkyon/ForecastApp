import 'package:flutter/material.dart';
import 'package:forecast_app/src/blocs/look_and_feel/look_and_feel.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';
import 'package:forecast_app/src/repositories/repositories.dart';
import 'package:kiwi/kiwi.dart' as c;

void initKiwi() {
  c.KiwiContainer().registerSingleton((c) => WeatherRepository());
  c.KiwiContainer().registerFactory((c) => CityRepository());
  c.KiwiContainer().registerFactory((c) => LocalTimeRepository());
  c.KiwiContainer().registerFactory((x) => WeatherBloc(
      weatherRepository: x.resolve(),
      cityRepository: x.resolve(),
      localTimeRepository: x.resolve()));
  c.KiwiContainer().registerSingleton((x) => ThemeBloc(ThemeState(
        theme: ThemeData(
            primaryColor: Colors.lightBlue,
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: Colors.white)),
            primaryIconTheme: IconThemeData(color: Colors.white)),
      )));
}
