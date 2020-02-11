import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/redux/site_diary/action_site_diary.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:sitediary/router.dart';
import 'package:redux/redux.dart';

import 'package:sitediary/ui/sitediary/site_diary_main_body.dart';

class SiteDiaryMain extends StatefulWidget {
  static Router router = Router('/site_diary/main_page','Site Diary');
  @override
  _SiteDiaryMainState createState() => _SiteDiaryMainState();
}

class _SiteDiaryMainState extends State<SiteDiaryMain> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);


    final  store = StoreProvider.of<SiteDiaryState>(context);
    final w = store.state.currentSiteDiaryWorker;
    print('SiteDiaryMain, currentSiteDiaryWorker: ${w.debugString()}');
    if (!w.isNeedReloadData){
      return Scaffold(
        appBar: AppBar(title: Text(SiteDiaryMain.router.buttonText),),
        body:SiteDiaryMainBody(w),
      );
    }
    Store<AppState> appStore = StoreProvider.of(context);
    final action1 = GetSiteDiaryWorkerServerActon(appStore.state);
    store.dispatch(action1);

    return FutureBuilder(
      future: action1.completer.future
        ,builder: (BuildContext context, AsyncSnapshot<void> async)
      {
          if (async.connectionState!=ConnectionState.done){
            return Scaffold(
              body: Container(
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              ),
            );
          }
          if (async.hasError){
            return Scaffold(
              appBar: AppBar(title: Text(SiteDiaryMain.router.buttonText),),
              body: Container(
                child: Center(
                  child: Text('${async.error}'),
                ),
              ),
            );
          }

          final state = store.state;
          final worker = state.currentSiteDiaryWorker;

          if (worker.RecordDate==null) worker.RecordDate = DateTime.now();

          print('${worker.debugString()}');

          return Scaffold(
            appBar: AppBar(title: Text(SiteDiaryMain.router.buttonText),),
            body:SiteDiaryMainBody(worker),
          );
      }

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

