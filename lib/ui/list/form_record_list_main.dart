import 'package:sitediary/datas/eform.dart';
import 'package:sitediary/redux/actions.dart';
import 'package:sitediary/redux/eform/state_eform.dart';
import 'package:sitediary/ui/list/repository_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../search/search_dialog.dart';
import 'form_record_tab_item.dart';

class FormRecordList extends StatefulWidget  {
  static String routeName = '/form_record_list_tab_main';
  final String eFormKey;

  FormRecordList(this.eFormKey);

  @override
  _FormRecordListState createState() => _FormRecordListState();
}

class _FormRecordListState extends State<FormRecordList> with AutomaticKeepAliveClientMixin  {
  final RepositoryServiceController repositoryServiceController = RepositoryServiceController();
  Widget _getTab(String t){
    return Tab(
      child:Container(
        decoration: BoxDecoration(
            color: Colors.lightBlue[50],
        ),
        child: Text(t,
            style: TextStyle(color: Colors.black54,fontSize: 18)),
      ),
    );
  }

  bool isActiveScreen = true;
  void fnActiveScreen(bool isActive){
    setState(() => isActiveScreen = isActive);
  }

  Widget _getAppBar(String subject){
    Store<AppState> appStore = StoreProvider.of(context);
   final so = appStore.state.user.userSearchOption;

    Store<EFormState> store = StoreProvider.of(context);
    EFormState state = store.state;

    return AppBar(
      title: Text(subject),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            so.hasSearchData?Icons.youtube_searched_for: Icons.search ,
            color: so.hasSearchData?Colors.amberAccent:null,
          ),
          onPressed: (){
            showDialog(context: context, builder: (c) {
              isActiveScreen = false;
              return SearchingDialog(so, state.currentEForm.itemSearchList??List<EFormItemSearch>());
            }).then((v){
              isActiveScreen = true;
              repositoryServiceController.resetRepositoryService();
              if (mounted) setState(() { });
            });
          }
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Store<EFormState> store = StoreProvider.of(context);
    EFormState state = store.state;
    //print('FormRecordList main build. sectionList: ${state.currentEForm.sectionList.length}');
    List<Tab> tabBars =List<Tab>();

    Store<AppState> appStore = StoreProvider.of<AppState>(context);

    int selectedSection = appStore.state.user.userSelectedSection??-999;
    int initIndex = 0;
    final f = state.currentEForm;
    final List<FormRecordTabItem> tabBarView =List<FormRecordTabItem>();

    for (int i=0;i<f.sectionList.length;i++){
      final s = f.sectionList[i];
      if (s.section ==selectedSection) initIndex = i;

      bool isBuildTab = false;
      if (s.section == f.initSection ){
        if (f.formUserRight.canCreate){
          isBuildTab = true;
        }
      }else{
        isBuildTab = true;
      }

      if (isBuildTab){
        tabBars.add(_getTab(s.recordStatusLabel));
        tabBarView.add(
            FormRecordTabItem(
              f, s.section, fnActiveScreen,
              repositoryServiceController,
            )
        );
      }

    }

    if (tabBars.length<= initIndex || initIndex < 0) initIndex = 0;
    //print('initIndex: $initIndex');
    return Scaffold(
      appBar: _getAppBar(f.subject),
      body: DefaultTabController(
        initialIndex: initIndex,
        length: tabBars.length,
        child: Scaffold(
          appBar:  TabBar(
              isScrollable: true,
              tabs: tabBars,
              onTap: (i){
                StoreProvider.of<AppState>(context).dispatch(
                    ChangeUserSelectedSectionAction(f.sectionList[i].section)
                );
              },
          ),
          body: TabBarView(
            children: tabBarView
          ),
        ),
      ),
      //bottomSheet: Text('bottomSheet'),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

