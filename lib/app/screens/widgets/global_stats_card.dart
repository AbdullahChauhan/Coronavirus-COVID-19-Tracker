import 'package:flutter/material.dart';

class GlobalStatsCard extends StatelessWidget {
  final String title;
  final Color color;
  final String assetName;
  final String value;
  final String mapText;
  final bool textChanged;

  const GlobalStatsCard(
      {Key key, this.title, this.color, this.assetName, this.value, this.mapText, this.textChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
              title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: color,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            AnimatedDefaultTextStyle(
              style: textChanged ? TextStyle(
                color: Colors.white30,
                fontSize: 12.0,
                letterSpacing: .5,
                fontStyle: FontStyle.italic
              ) : TextStyle(
                color: Colors.white12,
                fontSize: 10.0,
                letterSpacing: .5,
                fontStyle: FontStyle.italic
              ) ,
              duration: const Duration(milliseconds: 250),
                          child: Text(mapText),
            )
            ],),
            SizedBox(
              height: 6.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  assetName,
                  color: color,
                  width: 36.0,
                ),
                Text(value,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: color, fontWeight: FontWeight.w600))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
