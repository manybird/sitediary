import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sitediary/datas/eform/eform_item_section.dart';
import 'package:sitediary/datas/eform/eform_record.dart';
import 'package:sitediary/persistence/file_store.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';

import 'package:http/http.dart' as http;

import 'package:sitediary/datas/user.dart';
import 'package:sitediary/datas/http_handler.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:dio/dio.dart';

import 'package:sitediary/datas/request_sub_item.dart';

class MiddleWareEFormRecord{

  List<Middleware<EFormRecordState>> createStoreMiddlewareEFormRecord() {
    return [
      TypedMiddleware<EFormRecordState, CreateNewRecordServerAction>(_addNewFormRecordAndGetItFromServer),
      TypedMiddleware<EFormRecordState, GetFormRecordByRecordIdAction>(_getFormRecordOnServer),
      TypedMiddleware<EFormRecordState, SaveFormItemServerAction>(_saveFormRecordOnServer),
      TypedMiddleware<EFormRecordState, DownloadFileServerAction>(_downloadFileFromServer),
      TypedMiddleware<EFormRecordState, DownloadReportServerAction>(_downloadReportFromServer),
    ];
  }
  Future _downloadReportFromServer(Store<EFormRecordState> store, DownloadReportServerAction a, NextDispatcher next) async{

    EFormRecordState state = store.state;
    Dio dio = new Dio();

    RequestSubItem sub = RequestSubItem.fromUser(a.appState.user)
      ..eFormKey = state.currentEFormRecord.eFormKey
      ..eFormRecordID = state.currentEFormRecord.eFormRecordID
    ;

    RequestHandler rhFile = RequestHandler.fromSubItem(sub, 30); //GetPDF

    FileStorage fc = FileStorage('eFormReport/${DateTime.now().millisecondsSinceEpoch}report.pdf', true);

    File f = await fc.getFile;

    if (f.existsSync()){
      f.deleteSync();
    }else if(!f.parent.existsSync()){
      f.parent.createSync(recursive: true);
    }

    await dio.download(
        a.appState.serverUrlBase, f.path,
        onReceiveProgress: a.onReceiveProgress, data: rhFile.toJsonString(),
        options: Options(method: 'POST'),
    ).then((e){
      //f.writeAsBytesSync(e.data);
      print('_downloadReportFromServer success:');
      a.completer.complete(f);
    }).catchError((error){
      print('_downloadReportFromServer error: $error');
      a.completer.completeError(error);
    }).whenComplete(() {

    });
    /*
   await dio.post(
      a.appState.serverUrlBase,
      data: rhFile.toJsonString(),
      onReceiveProgress: a.onReceiveProgress,
       options: Options(responseType: ResponseType.bytes),
    ).then((e){
      //f.writeAsBytesSync(e.data);
     f.writeAsBytes(e.data).then((File f){
       print('_downloadReportFromServer success:');
       a.completer.complete(f);
     }).catchError((error){
       print('_downloadReportFromServer error: $error');
       a.completer.completeError(error);
     });

    }).catchError((error){
      print('_downloadReportFromServer error: $error');
      a.completer.completeError(error);
    }).whenComplete(() {

    });
*/
    next(a);
  }


  Future _downloadFileFromServer(Store<EFormRecordState> store, DownloadFileServerAction a, NextDispatcher next) async{

    Dio dio = new Dio();
    FileCopier fc = a.fileCopier;

    final r =fc.eFormRecordDetail;
    String savePath = await fc.getFullPath();
    String parameters = "?isDownload=1&eFormRecordID=${r.eFormRecordID}&eFormItemKey=${r.eFormItemKey}";
    await dio.download(
      a.appState.serverUrlBase + parameters, savePath,
      //data: rhFile.toJsonString(),
      onReceiveProgress: a.onReceiveProgress,
    ).catchError((error){
      try{
        File f = File(savePath);
        if (f.existsSync()) f.deleteSync();
      }catch(e){
      }

      a.completer.completeError(error);
      print('dio.download catchError: $error');
     }
     ).whenComplete((){
        if (!a.completer.isCompleted) a.completer.complete();
     });

    next(a);
  }

  Future<String> _uploadFileToServer(Store<EFormRecordState> store, SaveFormItemServerAction a) async {
    EFormRecordState state = store.state;
    Dio dio = new Dio();
    String errMsg;

    RequestSubItem sub = RequestSubItem.fromUser(a.appState.user)
      ..eFormKey = state.currentEFormRecord.eFormKey
      ..eFormRecordID = state.currentEFormRecord.eFormRecordID
    ;



    final list = state.currentEFormRecord.currentSectionObject.detailList;

    for(final d in list ){
      final r = d.recordDetail;
      final fileIsChanged = r.fileIsChanged??false;
      final isFile = r.isFile??false;
      if (!(isFile && fileIsChanged)) continue;

      FileCopier fc = FileCopier(r);

      if (r.itemPath!=null){
        File fSource = File( await fc.getFullPath());
        //int fileLength = fSource.lengthSync();
        await fc.doCopy(fSource);
        //r.itemValueDecimal = fileLength.toDouble();
        r.itemPath =  fc.relativePath;
      }

      sub.currentRecordDetail = r;
      RequestHandler rhFile = RequestHandler.fromSubItem(sub, 20);

      String fullFilePath = await fc.getFullPath();

      FormData formData = FormData.from({
        "requestHandler": rhFile.toJsonString(),
        "file": (r.itemPath??'') ==''?UploadFileInfo.fromBytes(utf8.encode("0"), "delete.tmp")
            : UploadFileInfo( File(fullFilePath), r.itemValue),
        //"file2": UploadFileInfo.fromBytes(utf8.encode("hello world"), "word.txt"),
        // //Multiple files support.
        //"files": [new UploadFileInfo(new File("./example/upload.txt"), "upload.txt")],
      });
      final res = await dio.post(
          a.appState.serverUrlBase, data: formData,
      );
      ResponseItem ri = ResponseItem.fromJsonString(res.data);

      if (!ri.isSuccess){
        return '${ri.message}. File path: ${r.itemPath}' ;
      }

      r.itemPathServer = ri.eformRecordDetailObject.itemPathServer;
      print( '_updateFileToServer $res' );

    }

    for(final d in list ) {
      final r = d.recordDetail;
      if (!r.isFile) continue;
      r.fileIsChanged = false;
    }

    return errMsg;

  }

  /// Save (Empty ServerAction but not null) or process SeverAction on Server
  Future _saveFormRecordOnServer(Store<EFormRecordState> store, SaveFormItemServerAction a, NextDispatcher next) async {
    EFormRecordState state = store.state;
    User u = a.appState.user;
    try {

      await http.get(a.appState.serverUrlBase); //testing url connection

      String s ;

      EFormRecord r = state.currentEFormRecord;

      //Private action
      if (r.currentSectionObject!=null){
        s = await _uploadFileToServer(store, a);
      }

      if (s==null) {
        RequestSubItem sub = RequestSubItem.fromUser(u)
          ..eFormKey = r.eFormKey
          ..eFormRecordID = r.eFormRecordID
          ..action = a.action
          ..currentSection = r.currentSectionObject
        ;
        if (sub.currentSection == null) {
          final sec = EFormItemSection.empty();
          sec.section = a.action.section;
          sec.eFormKey = r.eFormKey;
          sub.currentSection = sec;
        }

        RequestHandler rhMain = RequestHandler.fromSubItem(sub, a.requestTypeInt);

        http.post(
          a.appState.serverUrlBase,
          body: rhMain.toJsonString(),
        ).then((res) {
          ResponseItem ri = ResponseItem.fromJsonString(res.body);
          if(!ri.isSuccess){
            a.completer.completeError('${ri.message}');
          }else if (ri.eformObject!=null && ri.eformRecordObject!=null){
            store.state.currentEFormRecord = ri.eformRecordObject;
            a.completer.complete(store.state.currentEFormRecord );
          }else{
            a.completer.completeError('Error on _saveFormRecordOnServer: ${ri.message}.');
          }
        }).catchError((error) {
          a.completer.completeError(error);
        }).whenComplete(() {});

      }else {
        a.completer.completeError(s);
      }
    } catch (e) {
      a.completer.completeError(e);
    }
    next(a);
  }

  _addOrEditFormRecord(Store<EFormRecordState> store, ServerAction a, RequestHandler rh ){
        //store.state.isProcessingHttp = true;
      http.post(a.appState.serverUrlBase, body: rh.toJsonString())
          .then((res) {
        // The response body is an array of items
        ResponseItem ri = ResponseItem.fromJsonString(res.body);

        if(!ri.isSuccess){
          a.completer.completeError('${ri.message}');
        }else if (ri.eformObject!=null && ri.eformRecordObject!=null){
          store.state.currentEFormRecord = ri.eformRecordObject;
          a.completer.complete(store.state.currentEFormRecord );
        }else{
          a.completer.completeError('Error on _addOrEditFormRecord form.');
        }
      }).catchError((error) {
        a.completer.completeError(error);
      }).whenComplete(() { });
  }

  Future _getFormRecordOnServer(Store<EFormRecordState> store, GetFormRecordByRecordIdAction a, NextDispatcher next) async {
    AppState state = a.appState;

    User u = state.user;
    try {
      RequestSubItem sub = RequestSubItem.fromUser(u)
        ..eFormKey =a.eFormKey
        ..eFormRecordID = a.eFormRecordId
      ;
      RequestHandler rh = RequestHandler.fromSubItem(sub, a.requestTypeInt);
      _addOrEditFormRecord(store, a, rh);
    } catch (e) {
      a.completer.completeError(e);
    }

    next(a);
  }

  Future _addNewFormRecordAndGetItFromServer(Store<EFormRecordState> store, CreateNewRecordServerAction a, NextDispatcher next) async {
    try {

      User u = a.appState.user;

      RequestSubItem sub = RequestSubItem.fromUser(u)
        ..eFormKey = a.eFormKey;
      RequestHandler rh = RequestHandler.fromSubItem(sub, a.requestTypeInt);

      _addOrEditFormRecord(store, a, rh);
    } catch (e) {
      a.completer.completeError(e);
    }
    next(a);
  }

}

