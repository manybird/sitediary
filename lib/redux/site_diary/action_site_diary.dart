

import 'dart:async';

import 'package:sitediary/data_cache/paging_data.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/state_app.dart';

abstract class ServerActionSD{
  int pageSize;
  int pageIndex;
  Completer completer = Completer();
  Completer<PagingItemCollection> completerPagingItem = Completer();
  int requestTypeInt;
  final AppState appState;

  ServerActionSD(this.appState,{this.pageSize=0,this.pageIndex=0});
  setPaging(int pageIndex, int pageSize) {
    this.pageSize = pageSize;
    this.pageIndex = pageIndex;
  }
}

class SiteDiaryGetWorkerServerActon extends ServerActionSD {
  @override
  int requestTypeInt = 101;
  SiteDiaryGetWorkerServerActon(AppState appState) :
        super(appState);
}

class SiteDiaryGetLocationListServerActon extends ServerActionSD {
  @override
  int requestTypeInt = 110;
  SiteDiaryGetLocationListServerActon(AppState appState) :
        super(appState);
}

class SiteDiaryGetActivityListServerActon extends ServerActionSD {
  @override
  int requestTypeInt = 120;
  final SDLocationRecord locationRecord;
  SiteDiaryGetActivityListServerActon(AppState appState, this.locationRecord) :
        super(appState);
}

class LocalAction{
  Completer completer = Completer();
}

class SiteDiaryChangeWorkerAction extends LocalAction{
  final SiteDiaryWorker worker;
  SiteDiaryChangeWorkerAction(this.worker);
}

class SiteDiarySetCurrentLocationRecord extends LocalAction{
  final SDLocationRecord locationRecord;
  SiteDiarySetCurrentLocationRecord(this.locationRecord);
}
class SiteDiarySetCurrentActivityRecord extends LocalAction{
  final SDActivityRecord activityRecord;
  SiteDiarySetCurrentActivityRecord(this.activityRecord);
}