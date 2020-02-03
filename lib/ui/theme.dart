import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';

class UserTheme{
  static final textTheme = TextTheme(
    headline: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),);

  static ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
    fontFamily: 'Montserrat',
    textTheme: textTheme,);

  static ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Colors.orangeAccent[400],
    fontFamily: 'Montserrat',
    textTheme: textTheme,
  );

  static ThemeData osBaseTheme(){
    return kDefaultTheme;
    //return defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme;
  }

}