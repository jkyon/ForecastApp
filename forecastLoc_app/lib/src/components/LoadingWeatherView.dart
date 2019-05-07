import 'package:flutter/material.dart';
import 'package:forecast_app/src/ui/GradientBackground.dart';

class LoadingWeatherView extends StatelessWidget {

  const LoadingWeatherView({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GradientBackground(iconId: "00d"),
      Center(
        child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
      )
    ]);
  }
}
