import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData theme;
  //final MaterialColor color;

  ThemeState({@required this.theme}): super ([theme]);
  
}