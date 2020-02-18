import 'package:flutter/material.dart';
import 'package:sitediary/router.dart';
import 'package:sitediary/ui/sitediary/location/location_record_list.dart';


class SiteDiaryLocationMain extends StatefulWidget {

  static Router router = Router('/sitediary/location_main', 'Location List');

  @override
  _SiteDiaryLocationMainState createState() => _SiteDiaryLocationMainState();
}

class _SiteDiaryLocationMainState extends State<SiteDiaryLocationMain> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text(SiteDiaryLocationMain.router.buttonText),
      ),
        body: SiteDiaryLocationRecordList(),
    );
  }


}
