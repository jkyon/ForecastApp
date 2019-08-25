
import 'package:forecast_app/src/blocs/look_and_feel/look_and_feel.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';
import 'package:forecast_app/src/repositories/repositories.dart';
import 'package:kiwi/kiwi.dart';


void initKiwi(){
  Container().registerSingleton((c) => WeatherRepository());
  Container().registerFactory((c) => CityRepository());
  Container().registerFactory((c) => LocalTimeRepository());
  Container().registerFactory((x) => WeatherBloc(weatherRepository: x.resolve(), cityRepository: x.resolve(), localTimeRepository: x.resolve()));
  Container().registerSingleton((x) => ThemeBloc());
}