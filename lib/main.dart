import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:coronavirus_covid19_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_covid19_tracker/app/services/api.dart';
import 'package:coronavirus_covid19_tracker/app/services/api_service.dart';
import 'package:coronavirus_covid19_tracker/app/utils/app_utils.dart';
import 'package:coronavirus_covid19_tracker/app/screens/dashboard.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: primaryColor, // navigation bar color
    statusBarColor: primaryColor, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (context) => DataRepository(apiService: APIService(API())),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        title: 'Covid-19 Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: primaryColor,
          cardColor: secondaryColor,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: primaryColor
          ),
          dialogBackgroundColor: secondaryColor,
          appBarTheme: AppBarTheme(
            color: primaryColor
          )
        ),
        home: Dashboard()
      ),
    );
  }
}
