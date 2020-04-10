import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyUpdates extends StatelessWidget {
  final List<dynamic> dailyUpdates;
  final Color color1;
  final Color color2;

  const DailyUpdates({Key key, this.dailyUpdates, this.color1, this.color2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reversedList = dailyUpdates.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Cases per day'),
      ),
      body: ListView.builder(
          itemCount: reversedList.length,
          itemBuilder: (context, index) {
            final date = reversedList[index]['reportDate'];
            final confirmedCases = reversedList[index]['totalConfirmed'];
            final deaths = reversedList[index]['deaths']['total'];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Container(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  leading:
                      Icon(Icons.access_time, size: 28, color: Colors.cyan),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        DateFormat().add_yMMMd().format(DateTime.parse(date)),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.trending_down,
                            size: 18,
                            color: Colors.cyan,
                          ),
                          SizedBox(width: 6.0),
                          index == reversedList.length - 1
                              ? Text(
                                  'Confirmed: $confirmedCases',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          color: color1,
                                          fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  'Confirmed: ${confirmedCases - reversedList[index + 1]['totalConfirmed']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          color: color1,
                                          fontWeight: FontWeight.w600),
                                ),
                          SizedBox(width: 8.0),
                          index == reversedList.length - 1
                              ? Text(
                                  'Deaths: $deaths',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          color: color2,
                                          fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  'Deaths: ${deaths - reversedList[index + 1]['deaths']['total']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          color: color2,
                                          fontWeight: FontWeight.w600),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
