import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/data_cache/paging_data.dart';

import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/redux/site_diary/action_site_diary.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:sitediary/ui/sitediary/editor/list_button.dart';
import 'package:sitediary/ui/sitediary/location/location_tab_controller.dart';
import 'package:sitediary/ui/sitediary/record_list_mixin.dart';

class SiteDiaryLocationRecordList extends StatefulWidget {
  @override
  _SiteDiaryLocationRecordListState createState() => _SiteDiaryLocationRecordListState();
}

class _SiteDiaryLocationRecordListState extends State<SiteDiaryLocationRecordList> with RecordListMixin  {

  @override
  Future<PagingItemCollection> getDataFunction(int pageIndex, int pageSize) async{
    final s = StoreProvider.of<AppState>(ctx);
    final action1 = SiteDiaryGetLocationListServerActon(s.state);
    action1.setPaging(pageIndex, pageSize);
    StoreProvider.of<SiteDiaryState>(ctx).dispatch(action1);
    return action1.completerPagingItem.future;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildListPage();
  }

  @override
  Widget itemBuilder(BuildContext context, dynamic entry, int index) {
    SDLocationRecord record = entry;

    return Column(
      children: <Widget>[
        ListTile(
          leading: null,
          title: Text('${record.title}',overflow: TextOverflow.ellipsis,),
          subtitle: Text('${record.subTitle}',overflow: TextOverflow.ellipsis,),
          trailing: Column(

            children: <Widget>[
              ListButton(
                'Activity',
                onClick: ()=> _showItemDetail(record,1),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ) ,
          //Text( record.recordStatusLabel, style: TextStyle(color: Colors.lightBlue)),
          onTap: ()  {
            _showItemDetail(record,0);
          },
        ),
        Divider(),
      ],
    );

  }

  _showItemDetail( SDLocationRecord record,int initTabIndex){

    final store = StoreProvider.of<SiteDiaryState>(context);
    final action1 = SiteDiarySetCurrentLocationRecord(record);

    store.dispatch(action1);
    action1.completer.future.then((i){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            final rCopy = SDLocationRecord.fromJson(record.toJson());
            return SiteDiaryLocationTabController(rCopy,initTabIndex);
          },
      ),
      ).then((v){
        if (v==null) return;
        super.resetList();

        ////v should be SDLocationRecord after save
        //final action1 = SiteDiarySetCurrentLocationRecord(v);
        //store.dispatch(action1);

      });
    });
  }



}
