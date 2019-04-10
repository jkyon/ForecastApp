import 'package:flutter/material.dart';
import 'package:forecast_app/src/util/constants.dart';

class GradientBackground extends StatelessWidget {
  final String iconId;
  final Function(Color) callback;
  const GradientBackground({Key key, this.iconId, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBack(
          iconId: iconId,
        ),
      ],
    );
  }
}

class GradientBack extends StatelessWidget {
  final String iconId;
  final Function(Color) callback;
  const GradientBack({Key key, this.iconId, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradiendColor[iconId],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated)),
    );
  }
}
