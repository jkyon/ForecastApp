import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable{
  ThemeEvent([List props = const []]) : super(props);
}

class WeatherChanged extends ThemeEvent {
  final String conditionIconId;

  WeatherChanged({@required this.conditionIconId}) : super([conditionIconId]);
}