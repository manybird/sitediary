import 'package:redux/redux.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';

import 'action_site_diary.dart';

SiteDiaryState siteDiaryReducer(SiteDiaryState state, action) {
  return SiteDiaryState(
    _reducer(state.currentSiteDiaryWorker,action),
  );
}

final Reducer<SiteDiaryWorker> _reducer = combineReducers<SiteDiaryWorker>([
  TypedReducer<SiteDiaryWorker,SiteDiaryChangeWorkerAction>((SiteDiaryWorker worker,SiteDiaryChangeWorkerAction action){
    worker = action.worker;
    action.completer.complete();
    return worker;
  }),
  TypedReducer<SiteDiaryWorker,SiteDiarySetCurrentLocationRecord>((SiteDiaryWorker worker,SiteDiarySetCurrentLocationRecord action){
    worker.locationObject = action.locationRecord;
    action.completer.complete();
    return worker;
  }),
]);

