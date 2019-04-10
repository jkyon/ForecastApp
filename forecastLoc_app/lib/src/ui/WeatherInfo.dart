import 'package:flutter/material.dart';
import 'package:forecast_app/src/ui/RowIcon.dart';
import 'package:forecast_app/src/util/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class WeatherInfo extends StatelessWidget {
  final String forecastIcon;
  final String forecastDescription;
  final String temperature;
  final String humidity;
  final String maxTemp;
  final String minTemp;
  final String cityName;
  WeatherInfo({
    Key key,
    this.forecastIcon,
    this.forecastDescription,
    this.temperature,
    this.humidity,
    this.maxTemp,
    this.minTemp,
    this.cityName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          Text(
            cityName,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Text(
            DateFormat.yMMMMd("en_US").format(DateTime.now()),
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Icon(
            parameterIcons[forecastIcon],
            size: 200.0,
            color: Colors.white,
          ),
          Text(
            forecastDescription,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(""),
                    flex: 1,
                  ),
                  Text(
                    temperature,
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    MdiIcons.temperatureCelsius,
                    color: Colors.white,
                    size: 50,
                  ),
                  Expanded(
                    child: Text(""),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RowIncon(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                icon: Icon(
                  FontAwesome.getIconData('thermometer-empty'),
                  color: Colors.white,
                ),
                iconTextSymbol:
                    Icon(MdiIcons.temperatureCelsius, color: Colors.white),
                text: minTemp,
              ),
              RowIncon(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                icon: Icon(
                  FontAwesome.getIconData('thermometer-full'),
                  color: Colors.white,
                ),
                iconTextSymbol:
                    Icon(MdiIcons.temperatureCelsius, color: Colors.white),
                text: maxTemp,
              ),
              RowIncon(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                icon: Icon(
                  MdiIcons.water,
                  color: Colors.white,
                ),
                iconTextSymbol: Icon(MdiIcons.percent, color: Colors.white),
                text: humidity,
              ),
            ],
          )
        ],
      ),
    );
  }
}
