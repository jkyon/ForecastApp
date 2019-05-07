import 'package:flutter/material.dart';
import 'package:forecast_app/src/util/constants.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

class ColumnIcon extends StatelessWidget {
  final String dayOfWeek;
  final String icon;
  final String temp;
  ColumnIcon({Key key, this.dayOfWeek, this.icon, this.temp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    //final Function hp = Screen(MediaQuery.of(context).size).hp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(dayOfWeek,
            style: TextStyle(
                fontSize: wp(4),
                color: Colors.white,
                fontWeight: FontWeight.w400)),
        Icon(
          parameterIcons[icon],
          size: wp(12),
          color: Colors.white,
        ),
        Text(temp.toString() + "°C",
            style: TextStyle(
                fontSize: wp(4),
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
