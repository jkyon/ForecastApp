import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './look_and_feel.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeState initialState) : super(initialState);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is WeatherChanged) {
      yield _mapWeatherConditionToThemeData(event.conditionIconId);
    }
  }

  ThemeState _mapWeatherConditionToThemeData(String conditionIconId) {
    return ThemeState(
      theme: ThemeData(
          primaryColor: _themeColors[conditionIconId],
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white)),
          primaryIconTheme: IconThemeData(color: Colors.white)),
    );
  }

  final _themeColors = {
    '01d': Color(0xff0390e8),
    '01n': Color(0xff000077),
    '02d': Color(0xff0085ff),
    '02n': Color(0xff040434),
    '03d': Color(0xff0085ff),
    '03n': Color(0xff040434),
    '04n': Color(0xff040434),
    '04d': Color(0xff0085ff),
    '09n': Color(0xff0C1435),
    '09d': Color(0xff11487a),
    '10n': Color(0xff2d4627),
    '10d': Color(0xff93a4b0),
    '11n': Color(0xff11487a),
    '11d': Color(0xff93a4b0),
    '13n': Color(0xff0C1435),
    '13d': Color(0xffb7c2ce),
    '50n': Color(0xffd386a7),
    '50d': Color(0xffe6e5e0),
  };
}
