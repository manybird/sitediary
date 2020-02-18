import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/data_cache/paging_data.dart';
import 'package:sitediary/data_cache/repository_service.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/redux/site_diary/action_site_diary.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:sitediary/ui/sitediary/location/location_record_main.dart';

class SiteDiaryLocationRecordList extends StatefulWidget {

  @override
  _SiteDiaryLocationRecordListState createState() => _SiteDiaryLocationRecordListState();
}

class _SiteDiaryLocationRecordListState extends State<SiteDiaryLocationRecordList> {

  _showMessage( BuildContext context, String text){
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  RepositoryService repositoryService;
  BuildContext _context;

  Future<PagingItemCollection> getDataFunction(int pageIndex, int pageSize) async{
    final s = StoreProvider.of<AppState>(_context);
    final action1 = SiteDiaryGetLocationListServerActon(s.state);
    action1.setPaging(pageIndex, pageSize);
    StoreProvider.of<SiteDiaryState>(_context).dispatch(action1);
    return action1.completerPagingItem.future;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    repositoryService = RepositoryService(
      getDataFunction,
      logEnabled: true,
      pageSize: 15,
    );

    repositoryService.onFlushingCompleted = onFlushing;
    repositoryService.onFlushingBegin = onFlushing;
    repositoryService.onErrorCatch = onErrorCatch;
  }
  void onErrorCatch( error){
    if(mounted) {
      _showMessage(_context,'$error');
    }
  }

  void onFlushing(bool isFlushing){
    if(mounted) setState(() => this.isFlushing = isFlushing);
  }

  bool isFlushing = false;
  bool needGetItem = true;


  void preBuildProcess(){
    int waitTime =2000;
    if (repositoryService.counter==0) waitTime = 0;
    final d =DateTime.now();

    if(repositoryService.lastTime == 0 || d.millisecondsSinceEpoch > repositoryService.lastTime + 10 * 1000) {
      repositoryService.lastTime = d.millisecondsSinceEpoch;
      print(
          '${d.toIso8601String().substring(11,23)}: $SiteDiaryLocationRecordList, counter: ${repositoryService.counter}, total: ${repositoryService.totalProducts} '
      );
    }

    repositoryService.counter ++;

    if (needGetItem) {
      needGetItem = false;
      Future.delayed(Duration(milliseconds: waitTime), () {
        repositoryService.getItem(0).then((i){
          if(mounted) setState(() {});
        });//.getItem(0).then(onItemReceived);
        needGetItem = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    preBuildProcess();

    bool isLoading = repositoryService.totalProducts==null;

    return Scaffold(
      body: RefreshIndicator(
          onRefresh: (){
            repositoryService.clearAll();
            return Future.value();
          },
          child:  _buildBody(),
      ),
      bottomSheet:_buildBottomSheet(),
    );
  }

  Widget _buildBottomSheet(){
    final left = MediaQuery.of(context).size.width /2 -30;
    return Container(
      padding: EdgeInsets.fromLTRB(left,4,left,12),

      //width: MediaQuery.of(context).size.width -10,
      child: this.isFlushing
          ? Container(child:  RefreshProgressIndicator())
          :Text(
        'Total: ${repositoryService.totalProducts??0}',
        textAlign: TextAlign.center,
      ),
    ) ;
  }

  Widget _loading(){
    return Container(
      margin: EdgeInsets.only(top: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildBody() {
    return  repositoryService.totalProducts==null?_loading():Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: (repositoryService.totalProducts??0) ,
        itemBuilder: (context, i) {
          return _rowBuilder(repositoryService.getItem(i),i);
        },
      ),
    );
  }

  Widget _rowBuilder(Future<dynamic> productFuture,int index) {
    if (productFuture == null) {
      return Text("error loading item");
    } else {
      return FutureBuilder<dynamic>(
        future: productFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return _itemBuilder(context, snapshot.data, index);
          } else {
            return Container(height: 30,);
          }
        },
      );
    }
  }

  bool  isProcessing = false;

  Widget _itemBuilder(BuildContext context, dynamic entry, int index) {
    SDLocationRecord record = entry;

    return Column(
      children: <Widget>[
        ListTile(
          leading: null,
          title: Row(
            children: <Widget>[
              Text('${record.title}',overflow: TextOverflow.ellipsis,),
            ],
          ) ,
          subtitle: Row(
            children: <Widget>[
              Text('${record.subTitle}',overflow: TextOverflow.ellipsis,),
            ],
          ),
          trailing: Column(
            children: <Widget>[
              FlatButton(
                child: Text('Activity '),
                onPressed: (){
                  _showLocationMain(context,record,1);
                },
                color: Colors.grey[200],
              ),

            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ) ,
          //Text( record.recordStatusLabel, style: TextStyle(color: Colors.lightBlue)),
          onTap: ()  {
            _showLocationMain(context,record,0);
          },
        ),
        Divider(),
      ],
    );

  }

  _showLocationMain(context, SDLocationRecord record,int initTabIndex){
    if (isProcessing) return;
    isProcessing = true;
    print('_showLocationMain, $record');
    final store = StoreProvider.of<SiteDiaryState>(context);
    //store.state.currentSiteDiaryWorker.locationObject = record;
    final action1 = SiteDiarySetCurrentLocationRecord(record);
    store.dispatch(action1);
    action1.completer.future.then((i){
      print('_showLocationMain action completed, $record');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            final rCopy = SDLocationRecord.copy(record);
            return SiteDiaryLocationRecordMain(rCopy,initTabIndex);
          },
      ),
      );
      isProcessing = false;
    });
  }

}
