import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable{
  const ThemeEvent() ;
}

class WeatherChanged extends ThemeEvent {
  final String conditionIconId;

  const WeatherChanged({@required this.conditionIconId});

  @override
  List<Object> get props => [conditionIconId];
}