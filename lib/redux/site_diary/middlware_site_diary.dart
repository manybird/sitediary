
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:sitediary/datas/sitediary/http_handler_sitediary.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';

import 'action_site_diary.dart';

class MiddleWareSiteDiary{
  List<Middleware<SiteDiaryState>> create() {
    return [

      TypedMiddleware<SiteDiaryState, GetSiteDiaryWorkerServerActon>(_getSiteDiaryWorkerOnServer),
    ];
  }
  Future _getSiteDiaryWorkerOnServer(Store<SiteDiaryState> store, GetSiteDiaryWorkerServerActon action, NextDispatcher next) async {
    RequestHandlerSiteDiary responseItem;
    try {
      //print('_getSiteDiaryWorkerOnServer $action');

      print('_getSiteDiaryWorkerOnServer,  url: ${action.appState.serverUrlSD}, last get date: ${store.state.currentSiteDiaryWorker.lastReloadDataDate}');

      if (!store.state.currentSiteDiaryWorker.isNeedReloadData){
        next(action);
        action.completer.complete();
        return;
      }


      final u = action.appState.user;
      RequestHandlerSiteDiary rh = RequestHandlerSiteDiary(u);
      rh.requestTypeInt = action.requestTypeInt;
      //store.state.isProcessingHttp = true;



      post(action.appState.serverUrlSD, body: rh.toJsonString()).then((response){
        final responseBody = response.body;
        // The response body is an array of items
        responseItem = RequestHandlerSiteDiary.fromJsonString(responseBody);

        if (!responseItem.isSuccess && (responseItem.message??'')!=''){
          print('_getSiteDiaryWorkerOnServer error message, ${responseItem.message}');
          print('_getSiteDiaryWorkerOnServer responseBody, $responseBody');
          throw Exception(responseItem.message);
        }

        final state = store.state;

        if (responseItem.siteDiaryWorker==null){
          //Error here
          state.currentSiteDiaryWorker =SiteDiaryWorker();
        }else{

          if (state.currentSiteDiaryWorker==null){
            state.currentSiteDiaryWorker = SiteDiaryWorker();
          }

          final w = responseItem.siteDiaryWorker;
          final currentWorker =state.currentSiteDiaryWorker;
          currentWorker.contractCodeList = w.contractCodeList;
          currentWorker.teamList = w.teamList;
          currentWorker.staffList = w.staffList;

          currentWorker.lastReloadDataDate = DateTime.now();
        }

        action.completer.complete(responseItem);

      }).catchError((error){
        action.completer.completeError(error);
      }).whenComplete((){
        //Action when completed
        //store.state.isProcessingHttp = false;
      });

    } catch (e) {
      action.completer.completeError(e);
    }
    next(action);
  }
}