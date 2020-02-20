import 'dart:async';

import 'paging_data.dart';
import 'cache.dart';
import 'mem_cache.dart';
import 'repository.dart';

class RepositoryService extends Repository {
  final int pageSize;
  Function getDataFutureFunction;
  final Cache cache = MemCache<dynamic>();

  bool isFlushing = false;

  RepositoryService(  this.getDataFutureFunction, {this.pageSize=15, bool logEnabled}) :
       super(logEnabled: logEnabled??false) ;

  Function(bool) onFlushingCompleted;
  void raiseFlushingCompleted() async{
    this.isFlushing = false;
    if (onFlushingCompleted!=null) onFlushingCompleted(this.isFlushing);
    if (totalProducts==null) totalProducts = 0;
    //log('onFlushingCompleted: ');
  }

  Function(bool) onFlushingBegin;
  void raiseFlushingBegin() async{
    this.isFlushing = true;
    if (onFlushingBegin!=null) onFlushingBegin(this.isFlushing);
    //log('onFlushingBegin: ');
  }

  Function(Object) onErrorCatch;
  void raiseError(err) async{
    if (onErrorCatch!=null)   onErrorCatch(err);
    log('onErrorCatch: $err');
  }

  @override
  Future getItem(int index) {
    if (isEmpty) return Future.value();

    //wait for total items
    //if ( totalProducts==null && index >= totalProducts){ return Future.value(); }

    final pageIndex = pageIndexFromProductIndex(index);
    //print('pageIndex: $pageIndex, pagesCompleted: ${pagesCompleted.contains(pageIndex)}, pagesInProgress: ${pagesInProgress.contains(pageIndex)}');

    if (pagesCompleted.contains(pageIndex)) {
      return cache.get(index);
    } else {
      log('getItem not in cache: $index');
      if (!pagesInProgress.contains(pageIndex)) {
        pagesInProgress.add(pageIndex);
        final f = getDataFutureFunction(pageIndex, pageSize);
        log('type checking: f is Future<PagingItemCollection<dynamic>>: $f, ${f is Future<PagingItemCollection<dynamic>>}');
        raiseFlushingBegin();
        if (f is Future<PagingItemCollection<dynamic>>){
          Future<PagingItemCollection> future = f;
          future.then(onDataReceive).catchError(this.raiseError).whenComplete(raiseFlushingCompleted);
        }else{
          Future future = f;
          future.then((i){
            log('type checking $i');
          }).whenComplete(raiseFlushingCompleted);
        }
      }
      return buildFuture(index);
    }
  }

  @override
  Future buildFuture(int index) {
    var completer = Completer<dynamic>();

    if (completerMap[index] == null) {
      completerMap[index] = Set<Completer>();
    }
    completerMap[index].add(completer);

    log("*** Created future for $index");

    return completer.future;
  }

  @override
  int pageIndexFromProductIndex(int productIndex) {
    return productIndex ~/ pageSize;
  }


  void onDataReceive(PagingItemCollection<dynamic> p) async {
    log('onDataReceive: $p, ${p.items.length}');
    super.onData(p);
  }

  @override
  void clearAll(){
    super.clearAll();
    cache.clearAll();
  }

  @override
  void putToCache(int index, item) {
    cache.put(index, item);
  }

  @override
  void reportEmpty() {
    // TODO: implement reportEmpty
    log('Empty record reported!');
    isEmpty = true;
  }
}
