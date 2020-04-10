import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:coronavirus_covid19_tracker/app/services/api.dart';

/// This allows the `Covid19` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'covid19.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class Covid19 {
  final Map<String, dynamic> confirmed;
  final Map<String, dynamic> recovered;
  final Map<String, dynamic> deaths;
  final DateTime lastUpdate;

  Covid19({@required this.confirmed, @required this.recovered, @required this.deaths, @required this.lastUpdate});

  /// A necessary factory constructor for creating a new Covid19 instance
  /// from a map. Pass the map to the generated `_$Covid19FromJson()` constructor.
  /// The constructor is named after the source class, in this case, Covid19.
  factory Covid19.fromJson(Map<String, dynamic> json) => _$Covid19FromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$Covid19ToJson`.
  Map<String, dynamic> toJson() => _$Covid19ToJson(this);
}

class EndpointsData {
  final Map<Endpoint, List<dynamic>> values;

  EndpointsData({@required this.values});

  List<dynamic> get confirmed => values[Endpoint.confirmed];
  List<dynamic> get recovered => values[Endpoint.recovered];
  List<dynamic> get deaths => values[Endpoint.deaths];
  List<dynamic> get dailyUpdates => values[Endpoint.daily];
}