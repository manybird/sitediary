import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';


class SiteDiaryActivityEdit extends StatefulWidget {
  final SDActivityRecord record;
  SiteDiaryActivityEdit(this.record);
  @override
  _SiteDiaryActivityEditState createState() => _SiteDiaryActivityEditState();
}

class _SiteDiaryActivityEditState extends State<SiteDiaryActivityEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Edit'),
    );
  }
}
