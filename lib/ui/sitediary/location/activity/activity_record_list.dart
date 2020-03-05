import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/data_cache/paging_data.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/redux/site_diary/action_site_diary.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:sitediary/router.dart';
import 'package:sitediary/ui/sitediary/editor/list_button.dart';
import 'package:sitediary/ui/sitediary/record_list_mixin.dart';

import 'activity_tab_controller.dart';



class SiteDiaryActivityRecordList extends StatefulWidget {

  static Router router = Router('/sitediary/activity_record_list','Activity List');

  final SDLocationRecord locationRecord;
  SiteDiaryActivityRecordList(this.locationRecord);

  @override
  _SiteDiaryActivityRecordListState createState() => _SiteDiaryActivityRecordListState();
}

class _SiteDiaryActivityRecordListState extends State<SiteDiaryActivityRecordList> with RecordListMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildListPage();
  }

  @override
  Future<PagingItemCollection> getDataFunction(int pageIndex, int pageSize) {
    final s = StoreProvider.of<AppState>(ctx);
    final action1 = SiteDiaryGetActivityListServerActon(s.state,widget.locationRecord);
    action1.setPaging(pageIndex, pageSize);
    StoreProvider.of<SiteDiaryState>(ctx).dispatch(action1);
    return action1.completerPagingItem.future;
  }

  @override
  Widget itemBuilder(BuildContext context, dynamic entry, int index) {
    SDActivityRecord record = entry;

    return Column(
      children: <Widget>[
        ListTile(
          leading: null,
          title: Text(record.title??''),
          subtitle: Text(record.subTitle??'',overflow: TextOverflow.ellipsis,),
          trailing: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListButton(
                 'Labours', onClick: (){
                    _showItemDetail(record,1);
                  },
                ),
                ListButton(
                  'Plants', onClick: (){
                    _showItemDetail(record,2);
                  },
                ),
                ListButton(
                    'Photo', onClick: (){
                  _showItemDetail(record,4);
                }
                ),
                ListButton(
                  'Materials', onClick: (){
                    _showItemDetail(record,3);
                  }
                ),

              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
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

  _showItemDetail( SDActivityRecord record,int initTabIndex){

    final store = StoreProvider.of<SiteDiaryState>(context);
    //store.state.currentSiteDiaryWorker.locationObject = record;
    final action1 = SiteDiarySetCurrentActivityRecord(record);

    store.dispatch(action1);
    action1.completer.future.then((i){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          final rCopy = SDActivityRecord.fromJson(record.toJson());
          return SiteDiaryActivityTabController(rCopy,initTabIndex);
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

  @override
  void onFlushing(bool isFlushing) {
  }

}
