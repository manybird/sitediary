import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';

class SiteDiaryLabourRecordList extends StatefulWidget {

  final SDActivityRecord record;
  SiteDiaryLabourRecordList(this.record);
  @override
  _SiteDiaryLabourRecordListState createState() => _SiteDiaryLabourRecordListState();
}

class _SiteDiaryLabourRecordListState extends State<SiteDiaryLabourRecordList> {
  @override
  Widget build(BuildContext context) {
    return Container(child:Text('SiteDiaryLabourRecordList'));
  }
}
