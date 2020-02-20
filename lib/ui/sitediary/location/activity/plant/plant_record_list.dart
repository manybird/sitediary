import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/router.dart';


class SiteDiaryPlantRecordList extends StatefulWidget {

  final SDActivityRecord record;
  SiteDiaryPlantRecordList(this.record);
  @override
  _SiteDiaryPlantRecordListState createState() => _SiteDiaryPlantRecordListState();
}

class _SiteDiaryPlantRecordListState extends State<SiteDiaryPlantRecordList> {
  @override
  Widget build(BuildContext context) {
    return Container(child:Text('SiteDiaryPlantRecordList'));
  }
}
