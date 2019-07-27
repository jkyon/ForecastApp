import 'package:flutter/material.dart';
import 'package:forecast_app/src/ui/ui.dart';


class WeatherErrorView extends StatelessWidget {
  const WeatherErrorView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GradientBackground(
        iconId: '00d',
      ),
      Center(
        child: Text(
          "No Data Found",
          style: TextStyle(
              fontSize: 50, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      )
    ]);
  }
}
