import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';

import 'package:sitediary/router.dart';
import 'package:sitediary/ui/sitediary/location/activity/activity_record_list.dart';
import 'package:sitediary/ui/sitediary/location/location_edit.dart';
import 'package:sitediary/ui/sitediary/tab_bar.dart';

class SiteDiaryLocationTabController extends StatefulWidget {
  static Router router = Router('/sitediary/location_tab_controller', 'Location');

  final SDLocationRecord record;
  final int initTabIndex;
  SiteDiaryLocationTabController(this.record,this.initTabIndex);

  @override
  _SiteDiaryLocationTabControllerState createState() => _SiteDiaryLocationTabControllerState();
}

class _SiteDiaryLocationTabControllerState extends State<SiteDiaryLocationTabController> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(SiteDiaryLocationTabController.router.buttonText),
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
