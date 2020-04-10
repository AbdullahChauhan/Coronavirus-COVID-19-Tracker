import 'package:coronavirus_covid19_tracker/app/models/covid19.dart';
import 'package:coronavirus_covid19_tracker/app/services/api.dart';
import 'package:coronavirus_covid19_tracker/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;

  DataRepository({@required this.apiService});

  Future<Covid19> getRootData() async {
    try {
      final data = await apiService.getRootData();
      return data;
    } on Response catch (response) {
      // something else
      print(response);
      rethrow;
    }
  }

  Future<EndpointsData> getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(Endpoint.confirmed),
      apiService.getEndpointData(Endpoint.recovered),
      apiService.getEndpointData(Endpoint.deaths),
      apiService.getEndpointData(Endpoint.daily),
    ]);

    return EndpointsData(values: {
      Endpoint.confirmed: values[0],
      Endpoint.recovered: values[1],
      Endpoint.deaths: values[2],
      Endpoint.daily: values[3],
    });
  }

  Future<Covid19> getSingleCountryData(String countryName) async {
    try {
      final data =
          await apiService.getSingleCountryData(Endpoint.countries, countryName);
      return data;
    } on Response catch (response) {
      // something else
      print(response);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAllCountriesList() async {
    try {
      final data = await apiService.getAllCountriesList(Endpoint.countries);
      return data;
    } on Response catch (response) {
      // something else
      print(response);
      rethrow;
    }
  }
}
