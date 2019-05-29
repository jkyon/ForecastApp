
import 'package:flutter/material.dart';
import 'package:forecast_app/src/components/LoadingWeatherView.dart';
import 'package:forecast_app/src/components/MainWeatherInfo.dart';
import 'package:forecast_app/src/components/WeatherErrorView.dart';
import 'package:forecast_app/src/events/FetchWeatherEvent.dart';
import 'package:forecast_app/src/blocs/WeatherBloc.dart';
import 'package:forecast_app/src/models/LatLng.dart';
import 'package:forecast_app/src/states/WeatherState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/src/ui/PositionenTextField.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class WeatherWidget extends StatefulWidget {
  final LatLng latLng;

  WeatherWidget({Key key,this.latLng})
      : super(key: key);
      
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    this.weatherBloc = kiwi.Container().resolve<WeatherBloc>();
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
              return LoadingWeatherView();
            }
            if (state is WeatherLoadingState) {
              return LoadingWeatherView();
            }
            if (state is WeatherCompleteState) {
              return MainWeatherInfo(latLng: widget.latLng, state: state, weatherBloc: weatherBloc);
            }
            if (state is ErrorWeatherState) {
              return WeatherErrorView();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    this.weatherBloc.dispose();
    super.dispose();
  }
}
