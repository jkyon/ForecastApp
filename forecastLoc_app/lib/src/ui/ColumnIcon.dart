import 'package:flutter/material.dart';
import 'package:forecast_app/src/util/constants.dart';

class ColumnIcon extends StatelessWidget {
  final String dayOfWeek;
  final String icon;
  final String temp;
  ColumnIcon({Key key, this.dayOfWeek, this.icon, this.temp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(dayOfWeek,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400)),
        Icon(
          parameterIcons[icon],
          size: 40.0,
          color: Colors.white,
        ),
        Text(temp.toString() + "°C",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400)),
      ],
    );
  }
}
