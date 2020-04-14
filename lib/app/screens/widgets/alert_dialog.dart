import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget personalInfo(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Abdullah Chauhan', textAlign: TextAlign.center),
      SizedBox(height: 4.0),
      Text(
        'acse.uok@outlook.com',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      ),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Made with ',
              style: TextStyle(
                letterSpacing: .5,
              )),
          Icon(
            Icons.favorite,
            color: Colors.lightBlueAccent,
            size: 14,
          ),
          Text(' in Flutter', style: TextStyle(letterSpacing: .5)),
        ],
      )
    ],
  );
}

Future<void> showAlertDialog({
  @required BuildContext context,
  String title,
  CachedNetworkImage avatar,
  String content,
  @required bool isPersonalInfo,
  @required String defaultActionText,
}) async {
  // if platform is iOS
  if (Platform.isIOS) {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : avatar,
        content: isPersonalInfo ? personalInfo(context) : Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : avatar,
      content: isPersonalInfo ? personalInfo(context) : Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    ),
  );
}