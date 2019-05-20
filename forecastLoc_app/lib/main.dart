import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/src/IoC/WeatherAppIoC.dart';
import 'package:forecast_app/src/blocs/ThemeBloc.dart';
import 'package:forecast_app/src/models/LatLng.dart';
import 'package:forecast_app/src/states/ThemeState.dart';
import 'package:forecast_app/src/ui/WeatherWidget.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiwi/kiwi.dart' as kiwi;


Future<void> main() async {
  initKiwi();
  try {
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp, 
        DeviceOrientation.portraitDown
    ]);
    final Geolocator geolocator = Geolocator();
    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    runApp(MyApp(
      latLng: LatLng(position.latitude, position.longitude),
    ));
  } on PlatformException catch (e) {
    print(e);
  }
}

class MyApp extends StatefulWidget {
  final LatLng latLng;
  MyApp({Key key, @required this.latLng})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeBloc _themeBloc = kiwi.Container().resolve<ThemeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _themeBloc,
        child: BlocBuilder(
            bloc: _themeBloc,
            builder: (BuildContext context, ThemeState themeState) {
              return MaterialApp(
                  theme: themeState.theme,
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  home: WeatherWidget(
                    latLng: this.widget.latLng,
                  ),
              );
            }
        ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();    
    super.dispose();
  }
}
