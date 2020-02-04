import 'package:sitediary/redux/eform/state_eform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/redux/data_service.dart';
import 'package:sitediary/ui/template/list_template.dart';

import 'form_record_list_main.dart';
import 'package:sitediary/datas/eform/eform.dart';
import 'package:sitediary/redux/eform_action.dart';

class FormCategoryList extends StatefulWidget {
  static String routeName = '/form_category_page';
  @override
  _FormCategoryListState createState() => _FormCategoryListState();
}

class _FormCategoryListState extends State<FormCategoryList> with AutomaticKeepAliveClientMixin {
  int pageSize = 10;

  PagewiseLoadController<dynamic> pageLoadController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //print('Form Category List build.');
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Category'),
      ),
      body: PageWiseListTemplate( pageLoadController,itemBuilder),
    );
  }

  Widget itemBuilder(BuildContext context, dynamic entry, int index) {
    //print('FormCategoryList $entry');
    EForm f = entry;
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.brown[200],
          ),
          title: Text(f.subject??'[Null subject]'),
          subtitle: Text(f.subSubject??'[Null sub subject]'),
          onTap: () {

            Store<EFormState>  store = StoreProvider.of(context);
            final action1 = ChangeCurrentEFormAction(f);
            store.dispatch(action1);

            Future.wait([action1.completer.future]).then((List<dynamic> list){
              list.forEach((i){ });
            }).catchError((error){
              print('ChangeCurrentEFormAction: $error');
            }).whenComplete((){
              isActiveScreen = false;
              Navigator.push(context,MaterialPageRoute(builder: (c){
                return FormRecordList(f.eFormKey);
              })).then((f){
                isActiveScreen = true;
              });
            });
            //Navigator.pushNamed(context, FormRecordList.routeName);
          },
        ),
        Divider(),
      ],
    );
  }


  bool isActiveScreen = true;

  @override
  void initState() {
    super.initState();
    if (pageLoadController==null) {
      pageLoadController = PagewiseLoadController<dynamic>(
        pageSize: pageSize,
        pageFuture: (pageIndex) {
          return BackendService.getEForms(
            StoreProvider.of<AppState>(context).state, pageIndex * pageSize, pageSize,isActiveScreen
          );
        },
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

