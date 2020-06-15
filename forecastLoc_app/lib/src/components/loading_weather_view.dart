import 'package:flutter/material.dart';
import 'package:forecast_app/src/ui/gradient_background.dart';


class LoadingWeatherView extends StatefulWidget {

  const LoadingWeatherView({Key key,}) : super(key: key);

  @override
  _LoadingWeatherViewState createState() => _LoadingWeatherViewState();
}

class _LoadingWeatherViewState extends State<LoadingWeatherView> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GradientBackground(iconId: '00d'),
      Center(
        child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            ),
      )
    ]);
  }
}
