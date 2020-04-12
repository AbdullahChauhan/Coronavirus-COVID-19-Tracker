import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color primaryColor = Color(0xFF171B1E);
const Color secondaryColor = Color(0xFF1B232F);
const Color tertiaryColor = Color(0xFF243145);
const Color color_for_active = Color(0xFFFFF492);
const Color color_for_confirmed = Color(0xFFFFC814);
const Color color_for_recovered = Color(0xFF00CC99);
const Color color_for_deaths = Color(0xFFF76353);

String formattedValue(dynamic value) {
  if (value != null) {
    return NumberFormat('#,###,###,###').format(value);
  }
  return '';
}

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)} ...';
}

int calcPercentage(int numerator, int denominator) {
  if (numerator != null && denominator != null) {
    return ((numerator / denominator) * 100).toInt();
  }
  return 0;
}

Widget rateDisplay(BuildContext context, int numerator, int denominator,
    String text, Color color, TextStyle textStyle, bool inStart) {
  final percentageValue = calcPercentage(numerator, denominator);
  return Column(
    crossAxisAlignment:
        inStart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
    children: [
      Text(
        '$percentageValue%',
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
      ),
      Text('$text', style: textStyle)
    ],
  );
}
