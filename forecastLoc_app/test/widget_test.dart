
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';
import 'package:forecast_app/src/components/components.dart';
import 'package:forecast_app/src/models/models.dart';
import 'package:mockito/mockito.dart';
import 'package:kiwi/kiwi.dart'as kiwi;

import 'mocks/app_mocks.dart';

void main() {
  MockWeatherBloc mockWeatherBloc;
  setUp((){
    mockWeatherBloc = MockWeatherBloc();
    kiwi.Container().registerSingleton<WeatherBloc, MockWeatherBloc>((x) => mockWeatherBloc);
  });

  testWidgets('Displays the loading indicator when weather data is loading', (WidgetTester tester) async {

    when(mockWeatherBloc.currentState).thenReturn(WeatherLoadingState());
    await tester.pumpWidget(
      MaterialApp(
        home:  WeatherWidget(latLng: LatLng(37.42796133580664, -122.085749655962),
      )
    ));
     await tester.pump();
    
    final expected = find.byType(CircularProgressIndicator);

    expect(expected, findsOneWidget);

  });
}
