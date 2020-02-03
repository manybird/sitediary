import 'package:flutter/material.dart';

class LoadingApp extends StatelessWidget {
  static String routeName = '/loading';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(child: Text('Loading...')),
        ),
      ),
    );
  }
}
