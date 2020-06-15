import 'package:flutter/material.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';

class SearchAppBar extends StatefulWidget {
  final Widget body;
  final WeatherBloc weatherBloc;
  final Color color;
  SearchAppBar({Key key, this.body, this.weatherBloc, this.color})
      : super(key: key);
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  Widget appBarTitle =  Text('Search City');
  Icon actionIcon =  Icon(Icons.search);
  String _searchValue;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:
        AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                actionIcon =  Icon(Icons.close);
                appBarTitle =  TextField(
                  style:  TextStyle(
                    color: Colors.white,
                  ),
                  decoration:  InputDecoration(
                      prefixIcon:  Icon(Icons.search, color: Colors.white),
                      hintText: 'Search City...',
                      hintStyle:  TextStyle(color: Colors.white)),
                  onChanged: (String searchValue) {
                    _searchValue = searchValue;
                  },
                  onEditingComplete: () {
                    widget.weatherBloc..add(FetchWeatherEvent(cityName: _searchValue));
                  },
                );
              } else {
                actionIcon =  Icon(Icons.search);
                appBarTitle =  Text('Search City');
              }
            });
          },
        ),
      ]),
      body: widget.body,
    );
  }
}
