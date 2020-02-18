import 'package:sitediary/data_cache/paging_data.dart';
import 'package:sitediary/data_cache/repository_service.dart';
import 'package:sitediary/datas/eform/eform.dart';
import 'package:sitediary/redux/eform/state_eform.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';
import 'package:sitediary/ui/template/confirm_dialog.dart';
import 'package:sitediary/ui/list/repository_service_controller.dart';
import 'package:flutter/material.dart';

import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/redux/data_service.dart';
import 'package:sitediary/datas/eform/eform_record.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:sitediary/ui/edit/form_record_edit.dart';


class FormRecordTabItem extends StatefulWidget {

  final EForm eForm;
  final int section;
  final Function setActiveScreen;

  final RepositoryServiceController repositoryServiceController;
  //final Function reportRepositoryService;
  //final Function resetAllRepositoryService;

  FormRecordTabItem(
      this.eForm,
      this.section,
      this.setActiveScreen,
      this.repositoryServiceController,
      //this.reportRepositoryService,
      //this.resetAllRepositoryService,
  );

  @override
  _FormRecordTabItemState createState() => _FormRecordTabItemState();
}

class _FormRecordTabItemState extends State<FormRecordTabItem> with AutomaticKeepAliveClientMixin  {

  Future<PagingItemCollection> getDataFunction(int pageIndex, int pageSize) async{
    print('FormRecordTabItem, getDataFunction $pageIndex x $pageSize');
    if (context==null) return BackendService.getEFormRecordContainerEmpty();

    return BackendService.getEFormRecordContainer(
        StoreProvider.of<AppState>(context),
        widget.eForm.eFormKey ,
        widget.section,
        pageIndex , pageSize,isActiveScreen);
  }

  bool isProcessing =false;
  int pageSize = 10;
  bool isActiveScreen =true;
  RepositoryService repositoryService;


  Widget _createActionButton(BuildContext context){
    if (widget.section!=widget.eForm.initSection) return Container();

    Store<EFormState> formStore = StoreProvider.of(context);
    final f =formStore.state.currentEForm;
    if (f.formUserRight==null)  return Container();
    if (!f.formUserRight.canCreate) return Container();

    return FloatingActionButton(
      onPressed: () {

        showDialog(
          context: context,
          builder: (BuildContext context){
            return ConfirmDialog('Create new');
          }
        ).then((b){

          if(!b) return;

          if (isProcessing) return;
          isProcessing = true;

          final action1 = CreateNewRecordServerAction(f.eFormKey,StoreProvider.of<AppState>(context).state);
          StoreProvider.of<EFormRecordState>(context).dispatch(action1);
          _editRecord(context ,action1.completer.future,true);

          isProcessing = false;
        });


      },
      child: Icon(Icons.add),
    );
  }

  bool needGetItem = true;


  void preBuildProcess(){
    int waitTime =3000;
    if (repositoryService.counter==0) waitTime = 0;
    final d =DateTime.now();

    if(repositoryService.lastTime == 0 || d.millisecondsSinceEpoch > repositoryService.lastTime + 10 * 1000) {

      repositoryService.lastTime = d.millisecondsSinceEpoch;
      print(
          '${d.hour}:${d.minute}:${d.second} FormRecordTabItem: counter ${repositoryService.counter} , section: ${widget.section}, ${repositoryService.totalProducts} '
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
    super.build(context);

    preBuildProcess();

    return  Scaffold(
      floatingActionButton: _createActionButton(context),
      body: RefreshIndicator(
        onRefresh: (){
          repositoryService.clearAll();
          return Future.value();
        },
        child: _buildSuggestions(),
      ),
      bottomSheet:_buildBottomSheet(repositoryService.totalProducts==null),
    );
  }

  Widget _buildBottomSheet(bool isLoading){
    final left = MediaQuery.of(context).size.width /2 -30;
    return Container(
      padding: EdgeInsets.fromLTRB(left,4,left,12),

      //width: MediaQuery.of(context).size.width -10,
      child: isLoading
          ? Container(child:  RefreshProgressIndicator())
          :Text(
            'Total: ${repositoryService.totalProducts??0}',
            textAlign: TextAlign.center,
          ),
    ) ;
  }

  Widget _buildSuggestions() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: (repositoryService.totalProducts??0) ,
        itemBuilder: (context, i) {
          return _buildProductRow(repositoryService.getItem(i),i);
        },
      ),
    );
  }

  Widget _buildProductRow(Future<dynamic> productFuture,int index) {
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

  Widget itemBuilder(BuildContext context, dynamic entry, int index) {
    EFormRecord record = entry;
    List<Widget> list = List<Widget>();
    List<Widget> idWidgetList = List();
    record.itemDetailList.forEach((EFormRecordDetail d){
      if (d.isIdentity){
        idWidgetList.add(Text('${d.getValue??''}'));
      } else if (d.isShowOnList){
        list.add(
            Row( children: <Widget>[ Text('${d.getValue??''}')] )
        );
      }
    });
    return Column(
      children: <Widget>[
        ListTile(
          leading: Column(children: idWidgetList,mainAxisAlignment: MainAxisAlignment.center,) ,
          title: Column(children: list ),
          subtitle: Row(
            children: <Widget>[
              Text('${record.modifyBy} At ${record.modifyDateString}'),
            ],
          ) ,
          trailing: null,
          //Text( record.recordStatusLabel, style: TextStyle(color: Colors.lightBlue)),
          onTap: () async {

            if (isProcessing) return;
            isProcessing = true;

            Store<AppState>  appStore = StoreProvider.of(context);
            Store<EFormRecordState>  store = StoreProvider.of(context);
            final action1 = GetFormRecordByRecordIdAction(record.eFormKey, record.eFormRecordID,appStore.state);
            store.dispatch(action1);

            /*
            Future.wait([action1.completer.future]).then((List<dynamic> list){
              list.forEach((i){ });
            }).catchError((error){
              _showMessage(context, '$error');
              //print('CreateNewRecordAction error: $error');
            }).whenComplete((){
              //_editRecord(context);
            });
            */


            _editRecord(context, action1.completer.future,false);

            isProcessing = false;
          },
        ),
        Divider(),
      ],
    );
  }

  void _editRecord(  BuildContext context, Future future, bool isAddNew){
    processActiveScreen(false);

    Navigator.push(context,MaterialPageRoute(builder: (c){
      return FormRecordEditPage(future);
    })).then((v){
      processActiveScreen(true);
      //print('isSaved $v');
      if ( isAddNew || v??false == true){
        repositoryService.clearAll();
      }

    });
  }

  void processActiveScreen(bool isActive){
    isActiveScreen = isActive;
    widget.setActiveScreen(isActive);
  }



  @override
  void initState() {
    super.initState();
    repositoryService = widget.repositoryServiceController.createRepositoryService(
      getDataFunction, widget.section,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

