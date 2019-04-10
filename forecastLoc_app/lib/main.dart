import 'package:flutter/material.dart';
import 'package:forecast_app/src/models/LatLng.dart';
import 'package:forecast_app/src/repositories/WeatherRepository.dart';
import 'package:forecast_app/src/ui/WeatherWidget.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  try {
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp, 
        DeviceOrientation.portraitDown
    ]);
    final Geolocator geolocator = Geolocator();
    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    runApp(MyApp(
      weatherRepository: WeatherRepository(),
      latLng: LatLng(position.latitude, position.longitude),
    ));
  } on PlatformException catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  final LatLng latLng;
  MyApp({Key key, @required this.weatherRepository, @required this.latLng})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: WeatherWidget(
        latLng: this.latLng,
        weatherRepository: this.weatherRepository,
      ),
    );
  }
}
