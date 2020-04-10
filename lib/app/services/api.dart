enum Endpoint {
  confirmed,
  recovered,
  deaths,
  daily,
  countries
}

class API {
  static final String host = "covid19.mathdro.id";
  static final String basePath = "api";

  Uri apiCallUri() => Uri(
    scheme: "https",
    host: host,
    path: basePath,
  );

  Uri endpointUri(Endpoint endpoint) => Uri(
    scheme: "https",
    host: host,
    path: '$basePath/${_paths[endpoint]}'
  );

  Uri endpointUriForCountry(Endpoint endpoint, String country) => Uri(
    scheme: "https",
    host: host,
    path: '$basePath/${_paths[endpoint]}/$country'
  );

  Uri endpointUriForAllCountries(Endpoint endpoint) => Uri(
    scheme: "https",
    host: host,
    path: '$basePath/${_paths[endpoint]}'
  );

  static Map<Endpoint, String> _paths = {
    Endpoint.confirmed: 'confirmed',
    Endpoint.recovered: 'recovered',
    Endpoint.deaths: 'deaths',
    Endpoint.daily: 'daily',
    Endpoint.countries: 'countries',
  };
}