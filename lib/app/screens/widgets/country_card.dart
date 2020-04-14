import 'package:coronavirus_covid19_tracker/app/models/covid19.dart';
import 'package:coronavirus_covid19_tracker/app/screens/widgets/alert_dialog.dart';
import 'package:coronavirus_covid19_tracker/app/screens/widgets/chart.dart';
import 'package:coronavirus_covid19_tracker/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryCard extends StatelessWidget {
  final Covid19 countryData;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  final String countryName;
  final Widget rateDisplay1;
  final Widget rateDisplay2;

  const CountryCard({
    Key key,
    @required this.countryData,
    @required this.color1,
    @required this.color2,
    @required this.color3,
    @required this.color4,
    @required this.countryName,
    @required this.rateDisplay1,
    @required this.rateDisplay2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _confirmedCases = countryData.confirmed['value'];
    int _recoveredCases = countryData.recovered['value'];
    int _deaths = countryData.deaths['value'];
    int _activeCases = (_confirmedCases - _recoveredCases) - _deaths;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('COUNTRY UPDATE',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(letterSpacing: 1.25)),
                  GestureDetector(
                    child: Icon(
                      Icons.assignment_late,
                      size: 20.0,
                      color: Colors.white70,
                    ),
                    onTap: () => showAlertDialog(
                        context: context,
                        title: "Keep patience",
                        content:
                            "After selecting the new country, you've to wait for 1/3 secs so it will re-update the card. Its totally depend on your internet connection.",
                            isPersonalInfo: false,
                        defaultActionText: "Ok"),
                  )
                ],
              ),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: <Widget>[
                  Text('Last Updated at: ',
                      style: Theme.of(context).textTheme.caption),
                  Text(
                      '${DateFormat().add_yMMMMEEEEd().format(countryData.lastUpdate)}')
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                    color: Colors.white70,
                    width: 4.0,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(truncateWithEllipsis(20, countryName).toUpperCase(),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              letterSpacing: 1, fontWeight: FontWeight.w300)),
                      Text('Active cases: ${_activeCases.abs()}',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                letterSpacing: .5,
                              )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rateDisplay1 != null) rateDisplay1,
                  SizedBox(width: 16.0),
                  if (rateDisplay2 != null) rateDisplay2
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                children: <Widget>[
                  DataChart(
                    confirmed: _confirmedCases.toDouble(),
                    recovered: _recoveredCases.toDouble(),
                    deaths: _deaths.toDouble(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('$_confirmedCases',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w500)),
                      Text('Confirmed',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: color2,
                              )),
                      SizedBox(height: 12.0),
                      Text('$_recoveredCases',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w500)),
                      Text('Recovered',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: color3)),
                      SizedBox(height: 12.0),
                      Text('$_deaths',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w500)),
                      Text('Deaths',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: color4)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
