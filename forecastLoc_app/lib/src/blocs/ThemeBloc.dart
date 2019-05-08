import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:forecast_app/src/events/ThemeEvent.dart';
import 'package:forecast_app/src/states/ThemeState.dart';



class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
    theme: ThemeData(
          primaryColor: Colors.lightBlue,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)), 
          primaryIconTheme: IconThemeData(color: Colors.white)
    ), 
  );

  @override
  Stream<ThemeState> mapEventToState(
    ThemeState currentState,
    ThemeEvent event,
  ) async* {
    if(event is WeatherChanged){
      yield  _mapWeatherConditionToThemeData(event.conditionIconId);
    }
  }

  ThemeState _mapWeatherConditionToThemeData(String conditionIconId) {

    return ThemeState(
      theme: ThemeData(
          primaryColor: _themeColors[conditionIconId],
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)), 
          primaryIconTheme: IconThemeData(color: Colors.white)
      ),
    ); 
  }


  Map<String, Color> _themeColors = {
    '01d': Colors.lightBlue[400],
    '01n': Colors.indigo[900],
    '02d': Colors.blue[600],
    '02n': Colors.indigo[900],
    '03d': Colors.indigo[600],
    '03n': Colors.indigo[900],
    '03d': Colors.indigo[600],
    '04n': Colors.indigo[900],
    '09n': Colors.deepPurple[900],
    '09d': Colors.lightBlue[900],
    '10n': Colors.teal[900],
    '10d': Colors.blueGrey[300],
    '11n': Colors.lightBlue[900],
    '11d': Colors.blueGrey[300],
    '13n': Colors.deepPurple[900],
    '13d': Colors.blueGrey[200],
    '50n': Colors.pink[200],
    '50d': Colors.grey[300],
  };
}
