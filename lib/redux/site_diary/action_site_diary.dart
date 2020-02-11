

import 'dart:async';

import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/redux/state_app.dart';

abstract class ServerAction{
  final int offset;
  final int offsetCount;
  Completer completer = Completer();
  int requestTypeInt;
  final AppState appState;

  ServerAction(this.appState,{this.offset=0,this.offsetCount=0});
}

class GetSiteDiaryWorkerServerActon extends ServerAction {

  @override
  int requestTypeInt = 101;

  GetSiteDiaryWorkerServerActon(AppState appState) :
        super(appState);


}

class ChangeCurrentSiteDiaryWorkerAction{
  final SiteDiaryWorker worker;
  Completer completer = Completer();
  ChangeCurrentSiteDiaryWorkerAction(this.worker);
}