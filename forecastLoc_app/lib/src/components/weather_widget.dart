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
  WeatherBloc weatherBloc = kiwi.Container().resolve<WeatherBloc>();
  ThemeBloc themeBloc = kiwi.Container().resolve<ThemeBloc>();
  Completer<void> _refreshCompleter;

  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
      weatherBloc: weatherBloc,
      body: Center(
        child: BlocBuilder(
          cubit: weatherBloc,
          builder: (BuildContext context, WeatherState state) {
            if (state is WeatherEmptyState) {
              weatherBloc
                ..add(FetchWeatherEvent(
                    latitude: widget.latLng.latitude.toString(),
                    longitude: widget.latLng.longitude.toString(),
                    completer: _refreshCompleter));
              return LoadingWeatherView();
            }
            if (state is WeatherLoadingState) {
              return LoadingWeatherView();
            }
            if (state is WeatherCompleteState) {
              return MainWeatherInfo(
                  themeBloc: themeBloc,
                  latLng: widget.latLng,
                  state: state,
                  getWeatherInfo: (String latitude, String longitude) {
                    _refreshCompleter = Completer<void>();
                    weatherBloc
                      ..add(FetchWeatherEvent(
                          latitude: latitude,
                          longitude: longitude,
                          completer: _refreshCompleter));
                    return _refreshCompleter.future;
                  });
            }
            if (state is ErrorWeatherState) {
              return MainWeatherInfo(
                  themeBloc: themeBloc,
                  errorMessage: state.toString(),
                  latLng: LatLng(double.parse(state.latitude),
                      double.parse(state.longitude)),
                  getWeatherInfo: (String latitude, String longitude) {
                    _refreshCompleter = Completer<void>();
                    weatherBloc
                      ..add(FetchWeatherEvent(
                          latitude: latitude,
                          longitude: longitude,
                          completer: _refreshCompleter));
                    return _refreshCompleter.future;
                  });
            } else {
              return MainWeatherInfo(
                errorMessage: 'No data found',
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
