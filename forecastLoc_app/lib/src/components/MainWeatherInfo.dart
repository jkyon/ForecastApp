import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/src/blocs/ThemeBloc.dart';
import 'package:forecast_app/src/blocs/WeatherBloc.dart';
import 'package:forecast_app/src/events/FetchWeatherEvent.dart';
import 'package:forecast_app/src/events/ThemeEvent.dart';
import 'package:forecast_app/src/models/LatLng.dart';
import 'package:forecast_app/src/states/WeatherState.dart';
import 'package:forecast_app/src/ui/ForecastInfo.dart';
import 'package:forecast_app/src/ui/GradientBackground.dart';
import 'package:forecast_app/src/ui/WeatherInfo.dart';

class MainWeatherInfo extends StatefulWidget {
  final WeatherCompleteState state;
  final WeatherBloc weatherBloc;
  final LatLng latLng;

  MainWeatherInfo({Key key, this.latLng, this.state, this.weatherBloc})
      : super(key: key);

  _MainWeatherInfoState createState() => _MainWeatherInfoState();
}

class _MainWeatherInfoState extends State<MainWeatherInfo> {
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {

    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.dispatch(WeatherChanged(conditionIconId: widget.state.weather.icon));

    _refreshCompleter?.complete();
    _refreshCompleter = Completer();

    return Stack(
      children: <Widget>[
        GradientBackground(iconId: widget.state.weather.icon),
        RefreshIndicator(
          onRefresh: () {
            widget.weatherBloc.dispatch(FetchWeatherEvent(
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
