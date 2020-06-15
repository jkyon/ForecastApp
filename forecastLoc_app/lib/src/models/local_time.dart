import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocalTime extends Equatable {

  final TimeOfDay timeOfDay;

  final String timeZone;

  final String status;

  final String errorMessage;

  final String date;

  LocalTime({this.date,this.timeOfDay, this.timeZone, this.status, this.errorMessage});


  static LocalTime fromJson(dynamic json) {
    var parsedDate = DateTime.parse(json['formatted']);
    return LocalTime(
      date: DateFormat.yMMMMd('en_US').format(parsedDate),
      timeOfDay: TimeOfDay.fromDateTime(parsedDate),
      timeZone: json['zoneName'],
      status: json['status'],
      errorMessage: json['message']
    );
  }

  @override
  List<Object> get props => [date, timeOfDay, timeZone, status, errorMessage];
  
}