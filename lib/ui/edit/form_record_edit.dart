import 'dart:async';
import 'dart:io';

import 'package:sitediary/datas/eform_item_section.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';
import 'package:sitediary/ui/edit/form_record_edit_actionbar.dart';
import 'package:sitediary/ui/list/form_history.dart';

import 'package:flutter/material.dart';

import 'package:sitediary/redux/state_app.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:sitediary/datas/eform_record.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:sitediary/ui/edit_item/form_report_item.dart';
import 'section_view.dart';
import 'package:permission/permission.dart';
import 'jump_to_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



class FormRecordEditPage extends StatefulWidget {
  //final EForm eForm;
  final Future future;

  FormRecordEditPage(this.future);

  @override
  _FormRecordEditPageState createState() => _FormRecordEditPageState();
}

class _FormRecordEditPageState extends State<FormRecordEditPage> with TickerProviderStateMixin {

  JumpToController jumpToController ;
  int activeIndex = -1;
  bool _isProcessing = false;
  bool _isSaved = false;

  double _percentage =0;

  _showMessage( BuildContext context, String text){
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Object lastSender;
  onProgress(Object sender, bool isProcess, double percentage){
    if (!this.mounted)  return ;

    if (isProcess ){
      if (lastSender ==null){
        lastSender = sender;
      }else if (lastSender!=sender){
        return;
      }
    }else{
      if (lastSender==sender){
        lastSender = null;
      }else{
        return;
      }
    }

    print('onProgress: $isProcess, sender $sender, lastSender $lastSender');

    setState(() {
      _isProcessing = isProcess;
      _percentage = percentage;
    });
  }

  void doSaveFunction(BuildContext context, EFormItemSectionAction a, bool isPrivateAction){

    final it = this;
    onProgress(it, true,0);

    Store<EFormRecordState>  store = StoreProvider.of(context);

    if (!isPrivateAction){
      EFormRecordDetail rr = store.state.currentEFormRecord.currentSectionObject.canSaveCheck();

      //Report required on action only
      if (rr!=null && a!=null ){
        onProgress(it, false,0);

        String msg = "[${rr.itemLabel}] is required!.";

        if (rr.requiredMsg!=null){
          if (rr.requiredMsg.isNotEmpty){
            msg = rr.requiredMsg;
          }
        }

        _showMessage(context, msg );
        return;
      }
    }


    _isSaved = true;
    a = a??EFormItemSectionAction.empty();

    final action1 = SaveFormItemServerAction(
      a,
      StoreProvider.of<AppState>(context).state,
    );
    store.dispatch(action1);
    action1.completer.future.then((v){
      print('form_record_edit, SaveFormItemServerAction then, $v');
      _showMessage(context, '${a==null?'Save':a.actionLabel} completed.');

      final action2 = ReloadFormRecordEditAction(v);
      store.dispatch(action2);

      action1.completer.future.then((v){
      }).whenComplete((){
      });

    }).catchError((err){
      debugPrint('SaveFormItemServerAction Error: $err');
      _showMessage(context, 'Error: $err');
    }).whenComplete((){
      onProgress(it, false, 0);
    });
  }

  List<Widget> _createSectionList(EFormRecord r, bool isJustOnInit, bool isAbleToSave ){
    List<EFormItemSection> sectionList = r.sectionList;
    List<Widget> list2 = List<Widget>();

    for(int i =0 ;i < sectionList.length;i++){
      EFormItemSection s = sectionList[i];
      final theJumpKey = RectGetter.createGlobalKey();
      jumpToController.sectionItemKeys[i] = theJumpKey;

      bool isActive = r.isCurrentSection(s);

      if (isActive) {
        activeIndex = i;
        if (isJustOnInit && i >0){
          Timer(Duration(seconds: 1), () {
            jumpToController. jumpTo(activeIndex,false);
          });
        }
      }

      final c =Container(
        child:  SectionView(s, isActive,isAbleToSave, onProgress),
        margin: const EdgeInsets.all(6),
      );
      list2.add( RectGetter(
        key: theJumpKey,
        child: c,
      ));
    }

    //Add 100 empty space at end
    list2.add(Container(height: 100,));
    return list2;
  }

  Widget _buildBody() {
    //Store<AppState>  store = StoreProvider.of(context);

    return Container(
      child: StoreConnector<EFormRecordState, EFormRecordState>(
        converter: (Store<EFormRecordState> store) {
          return store.state;
        },
        builder: (BuildContext ctx, EFormRecordState state) {

          EFormRecord r = state.currentEFormRecord;
          if (r == null) return Container(child: Text('Loading...'));

          final currentSection = r.currentSectionObject;
          final actionList = currentSection==null?List<EFormItemSectionAction>(): currentSection.actionList;
          final actionListPrivate =  r.actionListPrivate;

          return Column(children: <Widget>[
            Flexible(
                child: RectGetter(
                  key: jumpToController. listViewKey,
                    child: SingleChildScrollView(
                      child: Column(
                          children: _createSectionList(r,false, actionList.length > 0)
                      )  ,
                      controller: jumpToController.scrollController,
                    ),
                  //child: list,
                ),
            ),
            Divider(height: 1),
            Container(
              child: Container(
                child: EditActionBar( _isProcessing, doSaveFunction, actionList, actionListPrivate??List<EFormItemSectionAction>()),
                margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
              ),//
              decoration: BoxDecoration(color: Theme
                  .of(ctx)
                  .cardColor),
              margin: EdgeInsets.only(bottom: 10),
            ),
          ],
          );
        }),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey[200])
        ),
      ),
    );
  }

  Widget _buildModalBody(){
    return ModalProgressHUD(
      child: _buildBody(),
      inAsyncCall: _isProcessing,
      dismissible: false,
      opacity :1,
      progressIndicator: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  SpinKitRing( color: Colors.redAccent[200], size: 60),
                Text('${(_percentage).toStringAsFixed(1) } %'),
              ],
            ),
          )
      ),
    );
  }

  BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    //print('form_record_edit build fire. ');
    mContext = context;
    Store<EFormRecordState>  store = StoreProvider.of(context);

    return WillPopScope(
      onWillPop: () async{
        if (_isProcessing) return false;
        Future.delayed(Duration(milliseconds: 100)).then((v){
          try{

            Navigator.pop(context,_isSaved);
          }catch  (ex){
            //Unsafe exception
            print(ex);
          }
        });
        return false;
      },
      child: FutureBuilder(
          future: widget.future,
          builder: (BuildContext context, AsyncSnapshot<void> async)
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
                body: Container(
                  child: Center(
                    child: Text('${async.error}'),
                  ),
                ),
              );
            }

            final state = store.state;
            final r = state.currentEFormRecord;

            List<Widget> list = List<Widget>();

            list.add(IconButton(
              icon: Icon(Icons.history),
              onPressed: (){
                Navigator.pushNamed(context, FormHistoryList.routeName);
              },
            ));


            if (r.currentSectionRight!=null){
              if (r.currentSectionRight.canReport){
                list.add(FormReportItem(r , onProgress ));
              }
            }

            return  Scaffold(
                appBar: AppBar(
                  title: Text('${r.recordStatusLabel}'),
                  actions: list,
                ),
                body:_buildModalBody(),
                floatingActionButton: Container(
                  margin: EdgeInsets.only(bottom: 80),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: "actionButtonJump",
                        onPressed: (){
                          if (activeIndex > -1) jumpToController.jumpTo(activeIndex,false);
                        },
                        child: Icon(Icons.gps_fixed),
                      ),
                    ],
                  ),
                ),
              ) ;
          }
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS){
      Permission.requestSinglePermission(PermissionName.Storage);
    }else{
      Permission.requestPermissions([PermissionName.Storage]).then((List<Permissions> listResult){
        listResult.forEach((Permissions p){
          print(p.permissionStatus);
        });
      });
    }
    jumpToController =  JumpToController();
    //Permission.getPermissionsStatus([PermissionName.Storage]).then((listResult){ });

  }

}

