import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PageWiseListTemplate extends StatefulWidget {

  final GlobalKey<RefreshIndicatorState> refreshKey= GlobalKey();
  final PagewiseLoadController<dynamic> pageLoadController;
  final Function itemBuilder;
  PageWiseListTemplate( this.pageLoadController,this.itemBuilder);


  @override
  _PageWiseListTemplateState createState() => _PageWiseListTemplateState();
}

class _PageWiseListTemplateState extends State<PageWiseListTemplate> with AutomaticKeepAliveClientMixin   {
  // int pageSize = 10;

  @override
  void initState() {
    super.initState();
    final c = widget.pageLoadController;
    c.addListener(() {
      if (c.hasMoreItems) return;
      //Scaffold.of(context) ..removeCurrentSnackBar()  ..showSnackBar( SnackBar(content: Text('No More Items!')));
    });
  }

  @override
  void dispose() {
    widget.pageLoadController.dispose();
    super.dispose();
  }

  Widget _getLoading(int mode){

    if (mode==1){
      return SpinKitHourGlass(
        color: Colors.red[300],
        size: 50.0,
      );
    }else if (mode==2){
      return SpinKitFadingCircle(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white10),
      child: Center(
          child: Text('Loading...${widget.pageLoadController.loadedItems.length}',
              style: TextStyle(fontSize: 20))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //print('PageWiseListView build');
    return RefreshIndicator(
      key: widget.refreshKey,
      onRefresh: () async {
        this.widget.pageLoadController.reset();
        await Future.value({});
      },
      child: PagewiseListView(
        itemBuilder: widget.itemBuilder,
        /// pageSize and pageFuture vs  pageLoadController
        //pageSize: pageSize,
        //pageFuture: (pageIndex) => BackendService.getPosts(pageIndex * pageSize, pageSize),

        addAutomaticKeepAlives: true,
        pageLoadController: this.widget.pageLoadController,
        noItemsFoundBuilder: (c) => Text('No Item found!'),
        loadingBuilder: (c) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: 30,),
              _getLoading(1),
            ],
          );
        },
        //retryBuilder: (context, callback) { return _retryButton(); },
        showRetry: false, errorBuilder: (context, error) => Text('Error: $error'),
      ),
    );
  }

//  Widget _retryButton(){
//    return RaisedButton(child: Text('Retry'), onPressed: () { widget.pageLoadController.retry(); });
//  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}
