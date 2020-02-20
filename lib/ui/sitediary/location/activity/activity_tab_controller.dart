
import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/router.dart';
import 'package:sitediary/ui/sitediary/location/activity/plant/plant_record_list.dart';
import 'package:sitediary/ui/sitediary/tab_bar.dart';

import 'activity_edit.dart';
import 'labour/labour_record_list.dart';

class SiteDiaryActivityTabController extends StatefulWidget {
  static Router router = Router('/sitediary/activity_tab_controller', 'Activity');
  final SDActivityRecord record;
  final int initTabIndex;
  SiteDiaryActivityTabController(this.record,this.initTabIndex);

  @override
  _SiteDiaryActivityTabControllerState createState() => _SiteDiaryActivityTabControllerState();
}

class _SiteDiaryActivityTabControllerState extends State<SiteDiaryActivityTabController>with AutomaticKeepAliveClientMixin  {
  @override
  Widget build(BuildContext context) {
    super.build(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(SiteDiaryActivityTabController.router.buttonText),
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
              SiteDiaryTabBar('Labour'),
              SiteDiaryTabBar('Plant'),
            ],
            onTap: (i){ },
          ),
          body: TabBarView(
            children: <Widget>[
              SiteDiaryActivityEdit(widget.record),
              SiteDiaryLabourRecordList(widget.record),
              SiteDiaryPlantRecordList(widget.record),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
