import 'package:flutter/material.dart';
import 'package:sitediary/router.dart';

class SiteDiaryLocationPage extends StatefulWidget {
  static Router router = Router('/site_diary/location_page', 'Location');
  @override
  _SiteDiaryLocationPageState createState() => _SiteDiaryLocationPageState();
}

class _SiteDiaryLocationPageState extends State<SiteDiaryLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(SiteDiaryLocationPage.router.buttonText),
      ),
      body: Container(),
    );
  }
}
