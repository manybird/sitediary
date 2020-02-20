
import 'package:flutter/material.dart';
import 'package:sitediary/data_cache/paging_data.dart';
import 'package:sitediary/data_cache/repository_service.dart';

import 'messenger.dart';

mixin RecordListMixin <T extends StatefulWidget> on State<T>{
  RepositoryService repositoryService;
  BuildContext ctx;

  Future<PagingItemCollection> getDataFunction(int pageIndex, int pageSize);

  void show(String text){

    Messenger.show(ctx, text??'');
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

  Widget buildListPage() {

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (){
          resetList();
          return Future.value();
        },
        child:   repositoryService.totalProducts==null?_loading():Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            itemCount: (repositoryService.totalProducts??0) ,
            itemBuilder: (context, i) {
              return _rowBuilder(repositoryService.getItem(i),i);
            },
          ),
        ),
      ),
      bottomSheet: this.buildBottomSheet(),
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
            return itemBuilder(context, snapshot.data, index);
          } else {
            return Container(height: 30,);
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    repositoryService = RepositoryService(
      getDataFunction,
      logEnabled: true,
      pageSize: 15,
    );

    repositoryService.onFlushingCompleted = onFlushing;
    repositoryService.onFlushingBegin = onFlushing;
    repositoryService.onErrorCatch = (error){
      show('$error');
    };
  }

  Widget itemBuilder(BuildContext context, dynamic entry, int index);

  void preBuildProcess(BuildContext context) async{
    if (ctx==null) ctx = context;

    if (repositoryService==null){

    }

    int waitTime =3000;
    if (repositoryService.counter==0) waitTime = 0;
    final d =DateTime.now();

    if(repositoryService.lastTime == 0 || d.millisecondsSinceEpoch > repositoryService.lastTime + 10 * 1000) {
      repositoryService.lastTime = d.millisecondsSinceEpoch;
      print(
          '${d.toIso8601String().substring(11,23)}: $this, counter: ${repositoryService.counter}, total: ${repositoryService.totalProducts} '
      );
    }
    repositoryService.counter ++;
    preBuildProcessGet(waitTime);
  }
  bool _bGetItem = true;
  void preBuildProcessGet(int waitTime){
    if (_bGetItem) {
      _bGetItem = false;
      Future.delayed(Duration(milliseconds: waitTime), () {
        if(!mounted) return;
        //print('${d.toIso8601String().substring(11,23)}, preBuildProcess: $waitTime');
        repositoryService.getItem(0).then(onGetItemCompleted);
      }).whenComplete((){
        _bGetItem = true;
      });
    }
  }

  @mustCallSuper
  Widget build(BuildContext context) {
    preBuildProcess(context);
    return null;
  }

  bool isFlushing = false;

  Widget buildBottomSheet(){
    final left = MediaQuery.of(ctx).size.width /2 -30;
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

  void resetList() async{
    repositoryService.clearAll();
  }

  void onFlushing(bool isFlushing){
    if(mounted) setState(() => this.isFlushing = isFlushing);
  }

  void onGetItemCompleted(i) {
    if(mounted) setState(() {});
  }
}