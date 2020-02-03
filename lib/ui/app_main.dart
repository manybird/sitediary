
import 'package:sitediary/persistence/location_camera.dart';
import 'package:sitediary/redux/eform/middleware_eform.dart';
import 'package:sitediary/redux/eform/state_eform.dart';
import 'package:sitediary/redux/eform_record/middleware_eform_record.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'google_map.dart';
import 'list/form_history.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sitediary/redux/middleware_app.dart';
import 'package:sitediary/redux/reducers_app.dart';
import 'package:sitediary/redux/eform_record/reducers_eform_record.dart';
import 'package:sitediary/redux/eform/reducers_eform.dart';
import 'loading.dart';
import 'app_home.dart';
import 'theme.dart';
import 'setting.dart';

import 'package:sitediary/ui/list/form_category.dart';

class AppMain extends StatefulWidget {

  static final routeName ='/app_main';
  final String title='Main';
  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {

  Store<AppState> appStore;

  Store<EFormRecordState> eFormRecordStore;
  Store<EFormState> eFormStore;

  Future<Store<AppState>> createStoreApp() async {
   await Future.delayed(Duration(seconds: 1));

   if (eFormStore == null) {
     eFormStore = Store<EFormState>(
       eFormReducer,
       initialState: EFormState.initial(),
       middleware: MiddleWareEForm().createStoreMiddlewareEForm(),
     );
   }

   if (eFormRecordStore == null) {
     eFormRecordStore = Store<EFormRecordState>(
       eFormRecordReducer,
       initialState: EFormRecordState.initial(),
       middleware: MiddleWareEFormRecord().createStoreMiddlewareEFormRecord(),
     );
   }

    if (appStore == null) {
      appStore = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: MiddleWareApp().createStoreMiddlewareApp(),
      );
    }
    return appStore;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createStoreApp(),
      builder: (BuildContext c, AsyncSnapshot<Store<AppState>> ss) {
        print(ss.connectionState);
        if (ss.connectionState != ConnectionState.done) {
          return LoadingApp();
        }
        return StoreProvider(
          store: eFormStore,
          child: StoreProvider(
            store: eFormRecordStore,
            child: StoreProvider(
              store: ss.data,
              child: MaterialApp(
                routes: {
                  AppMain.routeName: (c) => AppMain(),

                  FormCategoryList.routeName: (c)=>FormCategoryList(),
                  SettingScreen.routeName: (c)=>SettingScreen(true),
                  FormHistoryList.routeName: (c)=>FormHistoryList(),
                  LoadingApp.routeName: (c)=>LoadingApp(),
                  GoogleMapViewerApp.routeName: (c)=>GoogleMapViewerApp(LocationCamera()),
                },
                home: AppHome(),
                theme: UserTheme.osBaseTheme(),
              ),
            ),
          ),
        );
      },
    );
  }

}