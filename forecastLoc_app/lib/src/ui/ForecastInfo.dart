import 'package:flutter/material.dart';
import 'package:forecast_app/src/models/Forecast.dart';
import 'package:forecast_app/src/ui/ColumnIcon.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

class ForecastInfo extends StatelessWidget {
  final List<Forecast> forecast;
  ForecastInfo({
    Key key,
    this.forecast,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: hp(2)),
      child: Column(
        children: <Widget>[
          Text(
            "Next 5 days forecast",
            style: TextStyle(
                fontSize: wp(7), color: Colors.white, fontWeight: FontWeight.w400),
          ),
          Text(""),
          Wrap(
            spacing: wp(4),
            children: <Widget>[
              ColumnIcon(
                dayOfWeek: forecast[0].dayOfWeek,
                icon: forecast[0].icon,
                temp: forecast[0].temp.toString(),
              ),
              ColumnIcon(
                dayOfWeek: forecast[1].dayOfWeek,
                icon: forecast[1].icon,
                temp: forecast[1].temp.toString(),
              ),
              ColumnIcon(
                dayOfWeek: forecast[2].dayOfWeek,
                icon: forecast[2].icon,
                temp: forecast[2].temp.toString(),
              ),
              ColumnIcon(
                dayOfWeek: forecast[3].dayOfWeek,
                icon: forecast[3].icon,
                temp: forecast[3].temp.toString(),
              ),
              ColumnIcon(
                dayOfWeek: forecast[4].dayOfWeek,
                icon: forecast[4].icon,
                temp: forecast[4].temp.toString(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
