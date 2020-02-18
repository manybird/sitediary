import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/router.dart';
import 'package:sitediary/ui/sitediary/location/activity/activity_record_list.dart';
import 'package:sitediary/ui/sitediary/location/location_record_edit.dart';
import 'package:sitediary/ui/sitediary/tab_bar.dart';

class SiteDiaryLocationRecordMain extends StatefulWidget {
  static Router router = Router('/sitediary/location_record_main', 'Location');

  final SDLocationRecord record;
  final int initTabIndex;
  SiteDiaryLocationRecordMain(this.record,this.initTabIndex);

  @override
  _SiteDiaryLocationRecordMainState createState() => _SiteDiaryLocationRecordMainState();
}

class _SiteDiaryLocationRecordMainState extends State<SiteDiaryLocationRecordMain> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(SiteDiaryLocationRecordMain.router.buttonText),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.settings_applications),
            onPressed: (){ },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: widget.initTabIndex,
        child: Scaffold(
          appBar: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              SiteDiaryTabBar('Edit'),
              SiteDiaryTabBar(SiteDiaryActivityRecordList.router.buttonText),
            ],
            onTap: (i){
            },
          ),
          body: TabBarView(
            children: <Widget>[
              SiteDiaryLocationEdit(widget.record),
              SiteDiaryActivityRecordList(widget.record),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
