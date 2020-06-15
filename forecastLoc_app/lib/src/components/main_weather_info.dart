import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forecast_app/src/blocs/look_and_feel/look_and_feel.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';
import 'package:forecast_app/src/models/lat_lng.dart';
import 'package:forecast_app/src/ui/ui.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class MainWeatherInfo extends StatefulWidget {
  final WeatherCompleteState state;
  final WeatherBloc weatherBloc;
  final LatLng latLng;

  MainWeatherInfo({Key key, this.latLng, this.state, this.weatherBloc})
      : super(key: key);

  
  @override
  _MainWeatherInfoState createState() => _MainWeatherInfoState();
}

class _MainWeatherInfoState extends State<MainWeatherInfo> {
  final themeBloc = kiwi.Container().resolve<ThemeBloc>();
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {

    themeBloc..add(WeatherChanged(conditionIconId: widget.state.weather.icon));

    _refreshCompleter?.complete();
    _refreshCompleter = Completer();

    return Stack(
      children: <Widget>[
        GradientBackground(iconId: widget.state.weather.icon),
        RefreshIndicator(
          onRefresh: () {
            widget.weatherBloc..add(FetchWeatherEvent(
                latitude: widget.latLng.latitude.toString(),
                longitude: widget.latLng.longitude.toString()));
            return _refreshCompleter.future;
          },
          child: ListView(
            children: <Widget>[
              WeatherInfo(
                temperature: widget.state.weather.temp.toString(),
                forecastIcon: widget.state.weather.icon,
                cityName: widget.state.weather.cityName,
                forecastDescription: widget.state.weather.description,
                humidity: widget.state.weather.humidity.toString(),
                maxTemp: widget.state.weather.tempMax.toString(),
                minTemp: widget.state.weather.tempMin.toString(),
                localTime: widget.state.localTime.timeOfDay.format(context),
                currentDate: widget.state.localTime.date,
              ),
              ForecastInfo(
                forecast: widget.state.fiveDaysForecast,
              )
            ]
          ),
        )
      ],
    );
  }
}
