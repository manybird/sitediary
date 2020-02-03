import 'dart:async';
import 'dart:collection';


abstract class Repository {
  int totalProducts;
  final pagesInProgress = Set<int>();
  final pagesCompleted = Set<int>();
  final completerMap = HashMap<int, Set<Completer>>();

  bool logEnabled = false;

  bool isEmpty = false;

  Repository({this.logEnabled});

  void log(Object object) {
    if (logEnabled) {
      print(object);
    }
  }

  Future<dynamic> getItem(int index);
  int pageIndexFromProductIndex(int productIndex);

  Future<dynamic> buildFuture(int index);

  void putToCache( int index, dynamic item);

  void reportEmpty();

  void onData(dynamic dataItemCollection)  {
    if (dataItemCollection != null) {
      totalProducts = dataItemCollection.totalProducts;

      if (totalProducts==0){
        pagesInProgress.remove(dataItemCollection.pageNumber);
        for (int i = 0; i < dataItemCollection.pageSize; i++) {
          int index = dataItemCollection.pageSize *
              dataItemCollection.pageNumber + i;
          Set<Completer> comps = completerMap[index];
          if (comps != null) {
            for (var completer in comps) {
              log("*** Completed future for $index with null");
              completer.complete(null);
            }
            comps.clear();
          }
        }
        this.reportEmpty();
        return;
      }

      pagesInProgress.remove(dataItemCollection.pageNumber);
      pagesCompleted.add(dataItemCollection.pageNumber);

      //int itemTo = pageSize;
      //if (products.products.length < pageSize) itemTo = products.products.length;

      List list = dataItemCollection.items;

      for (int i = 0; i < dataItemCollection.pageSize; i++) {
        int index = dataItemCollection.pageSize * dataItemCollection.pageNumber + i;
        Set<Completer> comps = completerMap[index];

        if (i < list.length){
          final product = dataItemCollection.items[i];
          putToCache(index, product);

          if (comps != null) {
            for (var completer in comps) {
              log("*** Completed future for $index");
              completer.complete(product);
            }
            comps.clear();
          }
        }
        //cache.put(index, product);
      }
    } else {
      log("CachingRepository.onData(null)!!!");
    }
  }

  int counter =0;
  int lastTime = 0;
  void clearAll(){
    counter =0;
    lastTime =0;
    pagesInProgress.clear();
    pagesCompleted.clear();
    completerMap.clear();
    totalProducts = null;
    isEmpty = false;
  }

}