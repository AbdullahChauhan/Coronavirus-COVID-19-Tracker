import 'dart:convert';
import 'package:coronavirus_covid19_tracker/app/models/covid19.dart';
import 'package:coronavirus_covid19_tracker/app/services/api.dart';
import 'package:http/http.dart' as http;

class APIService {
  final API api;

  APIService(this.api);

  Future<Covid19> getRootData() async {
    final uri = api.apiCallUri();
    final response = await http.get(uri.toString());

    if (response.statusCode == 200) {
      Covid19 covid19 = Covid19.fromJson(json.decode(response.body));
      return covid19;
    }
    print(
        'Request ${api.apiCallUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<Covid19> getSingleCountryData(Endpoint endpoint, String country) async {
    final uri = api.endpointUriForCountry(endpoint, country);
    final response = await http.get(uri.toString());

    if (response.statusCode == 200) {
      Covid19 covid19 = Covid19.fromJson(json.decode(response.body));
      return covid19;
    }
    print(
        'Request ${api.endpointUriForCountry(endpoint, country)} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<Map<String, dynamic>> getAllCountriesList(Endpoint endpoint) async {
    final uri = api.endpointUriForAllCountries(endpoint);
    final response = await http.get(uri.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    }
    print(
        'Request ${api.endpointUriForAllCountries(endpoint)} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<List<dynamic>> getEndpointData(Endpoint endpoint) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(uri.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    }
    print(
        'Request ${api.endpointUri(endpoint)} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
