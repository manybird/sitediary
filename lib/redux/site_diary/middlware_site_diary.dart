import 'package:http/http.dart';
import 'package:redux/redux.dart';

import 'package:sitediary/data_cache/paging_data.dart';
import 'package:sitediary/datas/sitediary/http_handler_sitediary.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';

import 'action_site_diary.dart';

class MiddleWareSiteDiary{

  void log(Object object) {
    print('${DateTime.now().toIso8601String().substring(11,23)}: [MiddleWareSiteDiary] $object');
  }

  void throwErrorIfAny(RequestHandlerSiteDiary responseItem,String responseBody){
    if (!responseItem.isSuccess && (responseItem.message??'')!=''){
      log('_getSiteDiaryWorkerOnServer error message, ${responseItem.message}');
      log('_getSiteDiaryWorkerOnServer responseBody, $responseBody');
      throw Exception(responseItem.message);
    }
  }

  List<Middleware<SiteDiaryState>> create() {
    return [
      TypedMiddleware<SiteDiaryState, SiteDiaryGetWorkerServerActon>(_getSiteDiaryWorkerOnServer),
      TypedMiddleware<SiteDiaryState, SiteDiaryGetLocationListServerActon>(_getLocationListOnServer),
      TypedMiddleware<SiteDiaryState, SiteDiaryGetActivityListServerActon>(_getActivityListOnServer),
    ];
  }

  Future _getSiteDiaryWorkerOnServer(Store<SiteDiaryState> store, SiteDiaryGetWorkerServerActon action, NextDispatcher next) async {

    try {

      final state = store.state;
      final currentWorker =state.currentSiteDiaryWorker;

      log('_getSiteDiaryWorkerOnServer,  url: ${action.appState.serverUrlSD}, lastReloadBaseDataDate: ${currentWorker.lastReloadBaseDataDate}');
      if (currentWorker.isNeedReloadBaseData==false){
        next(action);
        action.completer.complete();
        return;
      }

      final u = action.appState.user;
      RequestHandlerSiteDiary rh = RequestHandlerSiteDiary(u);
      rh.requestTypeInt = action.requestTypeInt;

      post(action.appState.serverUrlSD, body: rh.toJsonString()).then((response){
        final responseBody = response.body;
        // The response body is an array of items
        RequestHandlerSiteDiary responseItem = RequestHandlerSiteDiary.fromJsonString(responseBody);

        if (!responseItem.isSuccess && (responseItem.message??'')!=''){
          log('_getSiteDiaryWorkerOnServer error message, ${responseItem.message}');
          log('_getSiteDiaryWorkerOnServer responseBody, $responseBody');
          throw Exception(responseItem.message);
        }

        if (responseItem.siteDiaryWorker==null){
          //Error here
          state.currentSiteDiaryWorker =SiteDiaryWorker();
        }else{

          if (state.currentSiteDiaryWorker==null){
            state.currentSiteDiaryWorker = SiteDiaryWorker();
          }

          final w = responseItem.siteDiaryWorker;

          currentWorker.contractCodeList = w.contractCodeList;
          currentWorker.teamList = w.teamList;
          currentWorker.staffList = w.staffList;

          if (currentWorker.RecordDate==null) {
            final d = DateTime.now();
            currentWorker.RecordDate = DateTime(d.year,d.month,d.day);
          }

          currentWorker.lastReloadBaseDataDate = DateTime.now();
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

  Future _getLocationListOnServer(Store<SiteDiaryState> store, SiteDiaryGetLocationListServerActon action,  next) async {

    try {
      final state = store.state;
      final worker = state.currentSiteDiaryWorker;
      log('_getLocationListOnServer,  url: ${action.appState.serverUrlSD}, lastReloadLocationListDate: ${worker.lastReloadLocationListDate}');

      final u = action.appState.user;

      RequestHandlerSiteDiary rh = RequestHandlerSiteDiary(u);
      rh.requestTypeInt = action.requestTypeInt;
      rh.siteDiaryWorker = worker.getWorkerForRequest();

      rh.pageSize = action.pageSize;
      rh.pageIndex = action.pageIndex;

      post(action.appState.serverUrlSD, body: rh.toJsonString()).then((response){
        final responseBody = response.body;
        // The response body is an array of items
        RequestHandlerSiteDiary responseItem = RequestHandlerSiteDiary.fromJsonString(responseBody);

        throwErrorIfAny(responseItem,responseBody);

        worker.lastReloadLocationListDate = DateTime.now();
        final rw = responseItem.siteDiaryWorker;

        log('locationRecordList: ${rw.locationRecordList.length}, total: ${responseItem.totalItem}');

        final pagingItemCollection = PagingItemCollection(
            pageNumber: action.pageIndex,pageSize: action.pageSize
          , items: rw.locationRecordList
          , totalProducts: responseItem.totalItem
        );

        if (rh.pageIndex==0){
          worker.subContractorList = rw.subContractorList;
          worker.areaList = rw.areaList;
          worker.woList = rw.woList;
          worker.locList = rw.locList;
          worker.streetList = rw.streetList;
          worker.reserve1List = rw.reserve1List;
          worker.reserve2List = rw.reserve2List;
        }

        action.completerPagingItem.complete(pagingItemCollection);


      }).catchError((error){
        action.completerPagingItem.completeError(error);
      }).whenComplete((){     });

    } catch (e) {
      action.completerPagingItem.completeError(e);
    }
    next(action);

  }
  Future _getActivityListOnServer(Store<SiteDiaryState> store, SiteDiaryGetActivityListServerActon action,  next) async {

    try {
      final state = store.state;
      final worker = state.currentSiteDiaryWorker;
      log('_getActivityListOnServer,  url: ${action.appState.serverUrlSD}');

      final u = action.appState.user;

      RequestHandlerSiteDiary rh = RequestHandlerSiteDiary(u);
      rh.requestTypeInt = action.requestTypeInt;
      rh.siteDiaryWorker = worker.getWorkerForRequest();

      rh.pageSize = action.pageSize;
      rh.pageIndex = action.pageIndex;

      post(action.appState.serverUrlSD, body: rh.toJsonString()).then((response){
        final responseBody = response.body;
        // The response body is an array of items
        RequestHandlerSiteDiary responseItem = RequestHandlerSiteDiary.fromJsonString(responseBody);

        throwErrorIfAny(responseItem,responseBody);

        action.locationRecord.lastReloadActivityListDate = DateTime.now();
        final rw = responseItem.siteDiaryWorker;

        log('ActivityRecordList: ${rw.activityRecordList.length}, Activity List: ${rw.activityList.length}, total: ${responseItem.totalItem}');

        final pagingItemCollection = PagingItemCollection(
            pageNumber: action.pageIndex,pageSize: action.pageSize
            , items: rw.activityRecordList
            , totalProducts: responseItem.totalItem
        );

        if (rh.pageIndex==0){
          worker.activityList = rw.activityList;
        }

        action.completerPagingItem.complete(pagingItemCollection);

      }).catchError((error){
        action.completerPagingItem.completeError(error);
      }).whenComplete((){     });

    } catch (e) {
      action.completerPagingItem.completeError(e);
    }
    next(action);

  }
}