import 'package:flutter/material.dart';
import 'package:forecast_app/src/ui/ui.dart';


class WeatherErrorView extends StatefulWidget {
  final String errorMessage;
  const WeatherErrorView({Key key, this.errorMessage}) : super(key: key);

  @override
  _WeatherErrorViewState createState() => _WeatherErrorViewState();
}

class _WeatherErrorViewState extends State<WeatherErrorView> {
  @override
  Widget build(BuildContext context) {

   displaySnack(context).then((success){
        Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(widget.errorMessage),
                
              ),
            );
      });
    return Stack(children: <Widget>[
      GradientBackground(
        iconId: '00d',
      ),
      Center(
        child: Text(
          '',
          style: TextStyle(
              fontSize: 50, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      )
    ]);
  }

   Future<bool> displaySnack(BuildContext context) async {
    return true;
  }
}
