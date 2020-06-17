import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/src/IoC/weather_app_ioc.dart';
import 'package:forecast_app/src/blocs/look_and_feel/look_and_feel.dart';
import 'package:flutter/services.dart';
import 'package:forecast_app/src/diagnostics/diagnostics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'src/blocs/base_bloc_delegate.dart';
import 'src/components/weather_widget.dart';
import 'src/models/lat_lng.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initKiwi();
  try {
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp, 
        DeviceOrientation.portraitDown
    ]);
    final geolocator = Geolocator();
    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    BlocSupervisor.delegate = BaseBlocDelegate(traceSource: TraceSource());
    
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

  final _themeBloc = kiwi.Container().resolve<ThemeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _themeBloc,
        child: BlocBuilder(
            bloc: _themeBloc,
            builder: (BuildContext context, ThemeState themeState) {
              return MaterialApp(
                  theme: themeState.theme,
                  debugShowCheckedModeBanner: false,
                  title: 'Weather Forecast',
                  home: WeatherWidget(
                    latLng: widget.latLng,
                  ),
              );
            }
        ),
    );
  }

  @override
  void dispose() {
    _themeBloc.close();
    super.dispose();
  }
}
