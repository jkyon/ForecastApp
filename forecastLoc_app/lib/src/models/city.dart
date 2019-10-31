
import 'package:equatable/equatable.dart';


class City extends Equatable {

  final String state;

  final String city;

  final String provience;

  final String timeZone;

  final String region;

  final String country;

  City({this.country, this.state, this.city, this.provience, this.timeZone, this.region});

  static City fromJson(dynamic json) {
    return City(
      city: json["city"],
      country: json["country"],
      state: json["state"],
      provience: json["prov"],
      region: json["region"],
      timeZone: json["timezone"]
    );
  }

  @override
  List<Object> get props => [state, city, provience, timeZone, region, country];


}