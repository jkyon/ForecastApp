import 'package:flutter/material.dart';
import 'package:forecast_app/src/blocs/look_and_feel/look_and_feel.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';
import 'package:forecast_app/src/models/lat_lng.dart';
import 'package:forecast_app/src/ui/ui.dart';

class MainWeatherInfo extends StatelessWidget {
  final WeatherCompleteState state;
  final LatLng latLng;
  final Function(String, String) getWeatherInfo;
  final ThemeBloc themeBloc;
  final bool dataFailed;

  MainWeatherInfo(
      {Key key,
      this.latLng,
      this.state,
      this.getWeatherInfo,
      this.themeBloc,
      this.dataFailed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !dataFailed
        ? _weatherInfoWidget(context)
        : _errorMessageWidget(context);
  }

  Widget _weatherInfoWidget(BuildContext context) {
    themeBloc..add(WeatherChanged(conditionIconId: state.weather.icon));
    return Stack(
      children: <Widget>[
        GradientBackground(iconId: state.weather.icon),
        RefreshIndicator(
          onRefresh: () => getWeatherInfo(
              latLng.latitude.toString(), latLng.longitude.toString()),
          child: ListView(children: <Widget>[
            WeatherInfo(
              temperature: state.weather.temp.toString(),
              forecastIcon: state.weather.icon,
              cityName: state.weather.cityName,
              forecastDescription: state.weather.description,
              humidity: state.weather.humidity.toString(),
              maxTemp: state.weather.tempMax.toString(),
              minTemp: state.weather.tempMin.toString(),
              localTime: state.localTime.timeOfDay.format(context),
              currentDate: state.localTime.date,
            ),
            ForecastInfo(
              forecast: state.fiveDaysForecast,
            )
          ]),
        )
      ],
    );
  }

  Widget _errorMessageWidget(BuildContext context) {
    return Stack(children: <Widget>[
      GradientBackground(iconId: '00d'),
      RefreshIndicator(
        onRefresh: () => getWeatherInfo(
            latLng.latitude.toString(), latLng.longitude.toString()),
        child: ListView(children: <Widget>[Text('')]),
      )
    ]);
  }
}
