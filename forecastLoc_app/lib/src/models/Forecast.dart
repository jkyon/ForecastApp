import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Forecast extends Equatable {

  final String main;

  final String description;

  final String icon;

  final int temp;

  final int humidity;

  final DateTime date;

  final String dayOfWeek;

  Forecast(
      {this.date,
      this.main,
      this.description,
      this.icon,
      this.temp,
      this.humidity,
      this.dayOfWeek})
      : super([date, main, description, icon, temp, humidity, dayOfWeek]);


  static List<Forecast> fromJson(dynamic json) {
    var forecastList = List<Forecast>();

    for (var item in json["list"]) {
      var date = DateTime.parse(item["dt_txt"]);
      var strDate = item["dt_txt"].toString().split(" ")[0];
      if (forecastList.firstWhere(
              (x) => x.date.toIso8601String().contains(strDate),
              orElse: () => null) !=
          null) {
        continue;
      }
      forecastList.add(Forecast(
          temp: (item["main"]["temp"]).toInt(),
          humidity: item["main"]["humidity"],
          description: item["weather"][0]["description"],
          main: item["weather"][0]["main"],
          icon: item["weather"][0]["icon"],
          date: date,
          dayOfWeek: DateFormat('EEEE').format(date)));
    }
    
    return forecastList;
  }
}
