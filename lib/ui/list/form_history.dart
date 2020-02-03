import 'package:sitediary/datas/eform_record_user_activity.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';
import 'package:flutter/material.dart';


import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


class FormHistoryList extends StatefulWidget  {
  static String routeName = '/form_history_page';
  FormHistoryList();

  @override
  _FormHistoryListState createState() => _FormHistoryListState();
}

class _FormHistoryListState extends State<FormHistoryList> with AutomaticKeepAliveClientMixin  {


  @override
  Widget build(BuildContext context) {
    super.build(context);
    Store<EFormRecordState> store = StoreProvider.of(context);
    List<EFormRecordUserActivity> list;
    if (store.state.currentEFormRecord!=null){
      list = store.state.currentEFormRecord.activityList;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('History')
      ),
      body: list==null?Container():_createBody(list)
    );
  }

  Widget _createBody(List<EFormRecordUserActivity> list){
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          EFormRecordUserActivity act = list[index];
          return Column(children: <Widget>[
            ListTile(
              trailing: Text(
                act.actionLabel??'', style: TextStyle(color: Colors.lightBlue[400]),
              ),
              title: Text(act.loginName??'') ,
              subtitle: Text(act.activityDateString),
            ),
            Divider(height: 2,),
          ],);
        },
        itemCount: list.length,
        padding: EdgeInsets.all(4),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

