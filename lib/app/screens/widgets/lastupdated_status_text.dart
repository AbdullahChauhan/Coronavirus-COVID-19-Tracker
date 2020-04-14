import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormatter {
  final DateTime lastUpdatedDate;

  LastUpdatedDateFormatter({@required this.lastUpdatedDate});

  String lastUpdatedStatusText() {
    if (lastUpdatedDate != null) {
      final formatter = DateFormat.yMMMMEEEEd().add_Hms();
      final formatted = formatter.format(lastUpdatedDate);
      return '$formatted';
    }
    return '';
  }
}

class LastUpdatedStatusText extends StatelessWidget {
  final String text;

  LastUpdatedStatusText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Updated at:',
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(
          height: 2.0,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
