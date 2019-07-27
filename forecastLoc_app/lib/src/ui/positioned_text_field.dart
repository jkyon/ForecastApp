import 'package:flutter/material.dart';
import 'package:forecast_app/src/blocs/weather/weather.dart';

class SearchAppBar extends StatefulWidget {
  final Widget body;
  final WeatherBloc weatherBloc;
  final Color color;
  SearchAppBar({Key key, this.body, this.weatherBloc, this.color})
      : super(key: key);
  @override
  _SearchAppBarState createState() => new _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  Widget appBarTitle = new Text("Search City");
  Icon actionIcon = new Icon(Icons.search);
  String _searchValue;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
          new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search City...",
                      hintStyle: new TextStyle(color: Colors.white)),
                  onChanged: (String searchValue) {
                    _searchValue = searchValue;
                  },
                  onEditingComplete: () {
                    widget.weatherBloc
                        .dispatch(FetchWeatherEvent(cityName: _searchValue));
                  },
                );
              } else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("Search City");
              }
            });
          },
        ),
      ]),
      body: widget.body,
    );
  }
}
