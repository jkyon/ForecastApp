import 'package:flutter/material.dart';
import 'package:forecast_app/src/ui/row_icon.dart';
import 'package:forecast_app/src/util/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';

class WeatherInfo extends StatelessWidget {

  final String forecastIcon;

  final String forecastDescription;

  final String temperature;

  final String humidity;

  final String maxTemp;

  final String minTemp;

  final String cityName;

  final String localTime;

  final String currentDate;

  WeatherInfo({
    Key key,
    this.forecastIcon,
    this.forecastDescription,
    this.temperature,
    this.humidity,
    this.maxTemp,
    this.minTemp,
    this.cityName,
    this.localTime,
    this.currentDate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final Function wp = Screen(MediaQuery.of(context).size).wp;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: wp(5)),
      child: Column(
        children: <Widget>[
          Text(
            cityName,
            style: TextStyle(
                fontSize: wp(10), color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Text(
            this.currentDate,
            style: TextStyle(
                fontSize: wp(5), color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Text(
            this.localTime,
            style: TextStyle(
                fontSize: wp(5), color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Icon(
            parameterIcons[forecastIcon],
            size: wp(40),
            color: Colors.white,
          ),
          Text(
            forecastDescription,
            style: TextStyle(
                fontSize: wp(8), color: Colors.white, fontWeight: FontWeight.w500),
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
                        fontSize: wp(20),
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    MdiIcons.temperatureCelsius,
                    color: Colors.white,
                    size: wp(10),
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
                fontSize: wp(10),
                icon: Icon(
                  FontAwesome.thermometer_empty,
                  color: Colors.white,
                ),
                iconTextSymbol:
                    Icon(MdiIcons.temperatureCelsius, color: Colors.white),
                text: minTemp,
              ),
              RowIncon(
                fontWeight: FontWeight.w300,
                fontSize: wp(10),
                icon: Icon(
                  FontAwesome.thermometer_full,
                  color: Colors.white,
                ),
                iconTextSymbol:
                    Icon(MdiIcons.temperatureCelsius, color: Colors.white),
                text: maxTemp,
              ),
              RowIncon(
                fontWeight: FontWeight.w300,
                fontSize: wp(10),
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
