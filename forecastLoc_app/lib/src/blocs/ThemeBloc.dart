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
    '01d': Color(0xff0390e8),//Colors.lightBlue[400],
    '01n': Color(0xff000077),//Colors.indigo[900],
    '02d': Color(0xff0085ff),//Colors.blue[600],
    '02n': Color(0xff040434),//Colors.indigo[900],
    '03d': Color(0xff0085ff),//Colors.indigo[600],
    '03n': Color(0xff040434),//Colors.indigo[900],
    '04n': Color(0xff040434),//Colors.indigo[900],
    '04d': Color(0xff0085ff),//Colors.indigo[900],
    '09n': Color(0xff0C1435),//Colors.deepPurple[900],
    '09d': Color(0xff11487a),//Colors.lightBlue[900],
    '10n': Color(0xff2d4627),//Colors.teal[900],
    '10d': Color(0xff93a4b0),//Colors.blueGrey[300],
    '11n': Color(0xff11487a),//Colors.lightBlue[900],
    '11d': Color(0xff93a4b0),//,Colors.blueGrey[300],
    '13n': Color(0xff0C1435),//Colors.deepPurple[900],
    '13d': Color(0xffb7c2ce),//Colors.blueGrey[200],
    '50n': Color(0xffd386a7),//Colors.pink[200],
    '50d': Color(0xffe6e5e0),//Colors.grey[300],
  };
}
