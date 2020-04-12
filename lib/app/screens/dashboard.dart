import 'dart:io';
import 'package:coronavirus_covid19_tracker/app/models/covid19.dart';
import 'package:coronavirus_covid19_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_covid19_tracker/app/screens/daily_update.dart';
import 'package:coronavirus_covid19_tracker/app/screens/map.dart';
import 'package:coronavirus_covid19_tracker/app/screens/widgets/alert_dialog.dart';
import 'package:coronavirus_covid19_tracker/app/screens/widgets/bottom_sheet.dart';
import 'package:coronavirus_covid19_tracker/app/screens/widgets/country_card.dart';
import 'package:coronavirus_covid19_tracker/app/screens/widgets/global_stats_card.dart';
import 'package:coronavirus_covid19_tracker/app/screens/widgets/lastupdated_status_text.dart';
import 'package:coronavirus_covid19_tracker/app/services/api.dart';
import 'package:coronavirus_covid19_tracker/app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _overallConfirmedCases;
  int _overallRecoveredCases;
  int _overallDeaths;
  EndpointsData _endpointsData;
  DateTime _lastUpdatedDate;
  Covid19 _countryData;
  List<dynamic> _countries;
  String _countryName;
  double _latitude;
  double _longitude;
  String _mapText;
  bool _textChanged;

  @override
  void initState() {
    _countryName = 'Pakistan';
    _mapText = 'Loading Map ...';
    _textChanged = false;
    _latitude = 30.3753;
    _longitude = 69.3451;
    _updateData();
    super.initState();
  }

  void updateCountry(String countryName) {
    setState(() {
      _countryName = countryName;
    });
    _getSingleCountryData(countryName);
    _updatedCountryCordinates(_endpointsData, Endpoint.confirmed);
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final rootData = await dataRepository.getRootData();
      setState(() {
        _overallConfirmedCases = rootData.confirmed['value'];
        _overallRecoveredCases = rootData.recovered['value'];
        _overallDeaths = rootData.deaths['value'];
        _lastUpdatedDate = rootData.lastUpdate;
      });
      _getEndpointsData();
      _getSingleCountryData(_countryName);
      _getAllCountries();
    } on SocketException catch (_) {
      // await is unnecessary here
      showAlertDialog(
          context: context,
          title: 'Connection error',
          content: 'Could not retreive data. Please try again later.',
          defaultActionText: 'Ok');
    }
  }

  Future<void> _getEndpointsData() async {
    final dataRepository1 = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository1.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointsData;
      _mapText = 'Tap to view map';
      _textChanged = true;
    });
  }

  Future<void> _getSingleCountryData(String countryName) async {
    final dataRepository2 = Provider.of<DataRepository>(context, listen: false);
    final countryData = await dataRepository2.getSingleCountryData(countryName);
    setState(() {
      _countryData = countryData;
    });
  }

  Future<void> _getAllCountries() async {
    final dataRepository2 = Provider.of<DataRepository>(context, listen: false);
    final countries = await dataRepository2.getAllCountriesList();
    setState(() {
      _countries = countries['countries'];
    });
  }

  void _updatedCountryCordinates(
      EndpointsData endpointsData, Endpoint endpoint) {
    final value = endpointsData.values[endpoint].where((country) =>
        country['countryRegion']
            .toLowerCase()
            .contains(_countryName.toLowerCase()));
    value.forEach((element) {
      setState(() {
        if (element['lat'] != null && element['long'] != null) {
          _latitude = element['lat'].toDouble();
          _longitude = element['long'].toDouble();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdatedDate: _lastUpdatedDate != null ? _lastUpdatedDate : null);
    final textStyleForRate = TextStyle(
      color: Colors.white30,
      fontSize: 12.0,
      letterSpacing: .5,
      fontStyle: FontStyle.italic,
    );
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text('Coronavirus COVID-19 Global Cases',
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: 8.0),
                  LastUpdatedStatusText(text: formatter.lastUpdatedStatusText())
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_endpointsData != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MapScreen(
                      endpointsData: _endpointsData.confirmed,
                      latitude: _latitude,
                      longitude: _longitude,
                      assetName: 'assets/icons/img_deaths_marker1.png',
                      confirmed: true,
                      recovered: false,
                      deaths: false,
                      title: 'Confirmed',
                    );
                  }));
                }
              },
              child: GlobalStatsCard(
                title: 'Total Confirmed',
                color: color_for_confirmed,
                assetName: 'assets/icons/fever.png',
                value: _overallConfirmedCases != null ? _overallConfirmedCases : 0,
                mapText: _mapText,
                textChanged: _textChanged,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_endpointsData != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MapScreen(
                      endpointsData: _endpointsData.recovered,
                      latitude: _latitude,
                      longitude: _longitude,
                      assetName: 'assets/icons/img_deaths_marker2.png',
                      confirmed: false,
                      recovered: true,
                      deaths: false,
                      title: 'Recovered',
                    );
                  }));
                }
              },
              child: GlobalStatsCard(
                title: 'Total Recovered',
                color: color_for_recovered,
                assetName: 'assets/icons/patient.png',
                value: _overallRecoveredCases != null ? _overallRecoveredCases : 0,
                mapText: _mapText,
                textChanged: _textChanged,
                rateDisplay: rateDisplay(
                    context,
                    _overallRecoveredCases,
                    _overallConfirmedCases,
                    'Recovery Rate',
                    color_for_recovered,
                    textStyleForRate,
                    true),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_endpointsData != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MapScreen(
                      endpointsData: _endpointsData.deaths,
                      latitude: _latitude,
                      longitude: _longitude,
                      assetName: 'assets/icons/img_deaths_marker3.png',
                      confirmed: false,
                      recovered: false,
                      deaths: true,
                      title: 'Death',
                    );
                  }));
                }
              },
              child: GlobalStatsCard(
                title: 'Total Deaths',
                color: color_for_deaths,
                assetName: 'assets/icons/death.png',
                value: _overallDeaths != null ? _overallDeaths : 0,
                mapText: _mapText,
                textChanged: _textChanged,
                rateDisplay: rateDisplay(
                    context,
                    _overallDeaths,
                    _overallConfirmedCases,
                    'Fatality Rate',
                    color_for_deaths,
                    textStyleForRate,
                    true),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _countryData != null
                    ? CountryCard(
                        countryData: _countryData,
                        countryName: _countryName,
                        color1: color_for_active,
                        color2: color_for_confirmed,
                        color3: color_for_recovered,
                        color4: color_for_deaths,
                        rateDisplay1: rateDisplay(
                            context,
                            _countryData.recovered['value'],
                            _countryData.confirmed['value'],
                            'Recovery Rate',
                            color_for_recovered,
                            textStyleForRate,
                            false),
                        rateDisplay2: rateDisplay(
                            context,
                            _countryData.deaths['value'],
                            _countryData.confirmed['value'],
                            'Fatality Rate',
                            color_for_deaths,
                            textStyleForRate,
                            false),
                      )
                    : Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 135.0),
                        child: CircularProgressIndicator(),
                      )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_endpointsData != null) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return DailyUpdates(
                            dailyUpdates: _endpointsData.dailyUpdates,
                            color1: color_for_confirmed,
                            color2: color_for_deaths,
                          );
                        }));
                      }
                    },
                    child: (Text(_endpointsData != null
                        ? 'Daily Updates'
                        : 'Loading ...')),
                    color: tertiaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  child: Text('Data source: https://covid19.mathdro.id/api',
                      style: Theme.of(context).textTheme.caption),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tertiaryColor,
        onPressed: () {
          if (_countries != null) {
            showCountriesList(
                context: context,
                countries: _countries,
                selectedCountry: updateCountry);
          }
        },
        child: Icon(
          Icons.public,
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }
}
