import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forecast_app/src/blocs/look_and_feel/look_and_feel.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/src/components/components.dart';
import 'package:forecast_app/src/models/models.dart';
import 'package:forecast_app/src/ui/ui.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class WeatherWidget extends StatefulWidget {
  final LatLng latLng;

  WeatherWidget({Key key, this.latLng}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  WeatherBloc weatherBloc = kiwi.KiwiContainer().resolve<WeatherBloc>();
  Completer<void> _refreshCompleter;

  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
      weatherBloc: weatherBloc,
      body: Center(
        child: BlocConsumer(
          cubit: weatherBloc,
          listener: (BuildContext context, WeatherState state) {
            if (state is ErrorWeatherState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(state.toString()),
                ),
              );
            }
          },
          builder: (BuildContext context, WeatherState state) {
            if (state is WeatherEmptyState) {
              weatherBloc.getWeather(
                  latitude: widget.latLng.latitude.toString(),
                  longitude: widget.latLng.longitude.toString(),
                  completer: _refreshCompleter);
              return LoadingWeatherView();
            }
            if (state is WeatherLoadingState) {
              return LoadingWeatherView();
            }
            if (state is WeatherCompleteState) {
              return _createWeatherInfoView(widget.latLng, false, state);
            }
            if (state is ErrorWeatherState) {
              return _createWeatherInfoView(
                  LatLng(double.parse(state.latitude),
                      double.parse(state.longitude)),
                  true,
                  null);
            } else {
              return _createWeatherInfoView(null, true, null);
            }
          },
        ),
      ),
    );
  }

  Widget _createWeatherInfoView(
      LatLng latLng, bool errorMessage, WeatherCompleteState state) {
    return MainWeatherInfo(
        themeBloc: BlocProvider.of<ThemeBloc>(context),
        dataFailed: errorMessage, //state.toString(),
        latLng: latLng,
        state: state,
        getWeatherInfo: (String latitude, String longitude) {
          _refreshCompleter = Completer<void>();
          weatherBloc.getWeather(
              latitude: latitude,
              longitude: longitude,
              completer: _refreshCompleter);
          return _refreshCompleter.future;
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
