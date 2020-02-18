import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/router.dart';

class SiteDiaryActivityRecordList extends StatefulWidget {

  static Router router = Router('/sitediary/activity_record_list','Activity List');

  final SDLocationRecord locationRecord;
  SiteDiaryActivityRecordList(this.locationRecord);

  @override
  _SiteDiaryActivityRecordListState createState() => _SiteDiaryActivityRecordListState();
}

class _SiteDiaryActivityRecordListState extends State<SiteDiaryActivityRecordList> {
  @override
  Widget build(BuildContext context) {
    return Container( child:Text( 'Activity List'));
  }
}
