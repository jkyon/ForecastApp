import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forecast_app/src/events/FetchWeatherEvent.dart';
import 'package:forecast_app/src/blocs/WeatherBloc.dart';
import 'package:forecast_app/src/models/LatLng.dart';
import 'package:forecast_app/src/repositories/WeatherRepository.dart';
import 'package:forecast_app/src/states/WeatherState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/src/ui/ForecastInfo.dart';
import 'package:forecast_app/src/ui/GradientBackground.dart';
import 'package:forecast_app/src/ui/PositionenTextField.dart';
import 'package:forecast_app/src/ui/WeatherInfo.dart';

class WeatherWidget extends StatefulWidget {
  final WeatherRepository weatherRepository;
  final LatLng latLng;
  WeatherWidget({Key key, this.weatherRepository, this.latLng})
      : super(key: key);
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  WeatherBloc weatherBloc;
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    this.weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
  }

  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
      weatherBloc: this.weatherBloc,
      body: Center(
        child: BlocBuilder(
          bloc: this.weatherBloc,
          builder: (BuildContext context, WeatherState state) {
            if (state is WeatherEmptyState) {
              weatherBloc.dispatch(FetchWeatherEvent(
                  latitude: widget.latLng.latitude.toString(),
                  longitude: widget.latLng.longitude.toString()));
              return Stack(children: <Widget>[
                GradientBackground(iconId: "00d"),
                Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white)),
                )
              ]);
            }
            if (state is WeatherLoadingState) {
              return Stack(children: <Widget>[
                GradientBackground(
                  iconId: "00d",
                ),
                Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white)),
                )
              ]);
            }
            if (state is WeatherCompleteState) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return Stack(
                children: <Widget>[
                  GradientBackground(iconId: state.weather.icon),
                  RefreshIndicator(
                    onRefresh: () {
                      weatherBloc.dispatch(FetchWeatherEvent(
                          latitude: widget.latLng.latitude.toString(),
                          longitude: widget.latLng.longitude.toString()));
                      return _refreshCompleter.future;
                    },
                    child: ListView(children: <Widget>[
                      WeatherInfo(
                        temperature: state.weather.temp.toString(),
                        forecastIcon: state.weather.icon,
                        cityName: state.weather.cityName,
                        forecastDescription: state.weather.description,
                        humidity: state.weather.humidity.toString(),
                        maxTemp: state.weather.tempMax.toString(),
                        minTemp: state.weather.tempMin.toString(),
                      ),
                      ForecastInfo(
                        forecast: state.fiveDaysForecast,
                      )
                    ]),
                  )
                ],
              );
            }
            if (state is ErrorWeatherState) {
              return Stack(children: <Widget>[
                GradientBackground(
                  iconId: '00d',
                ),
                Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ]);
            }
          },
        ),
      ),
    );
  }
}
