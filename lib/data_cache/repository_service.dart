import 'dart:async';
import 'cache.dart';
import 'mem_cache.dart';
import 'repository.dart';



class RepositoryService extends Repository {
  final int pageSize;
  final Function getDataFunction;
  final Cache cache = MemCache<dynamic>();


  RepositoryService(  this.getDataFunction, this.pageSize, {bool logEnabled}) :
       super(logEnabled: logEnabled??false) ;

  @override
  Future<dynamic> getItem(int index) {

    if (isEmpty) return Future.value();

    //wait for total items
    //if ( totalProducts==null && index >= totalProducts){ return Future.value(); }

    final pageIndex = pageIndexFromProductIndex(index);

    if (pagesCompleted.contains(pageIndex)) {
      return cache.get(index);
    } else {
      if (!pagesInProgress.contains(pageIndex)) {
        pagesInProgress.add(pageIndex);
        Future future = getDataFunction(pageIndex, pageSize);
        future.then(onData).whenComplete((){
          if (totalProducts==null) {
            totalProducts = 0;
          }
        });
      }
      return buildFuture(index);
    }
  }

  @override
  Future<dynamic> buildFuture(int index) {
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

  @override
  void onData(dynamic p)  {
    //PagingItemCollection<Product> products = p;
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
    print('empty reported!');
    isEmpty = true;
  }
}
