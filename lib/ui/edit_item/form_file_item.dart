import 'dart:io';
import 'dart:typed_data';
import 'package:sitediary/persistence/file_store.dart';
import 'package:sitediary/persistence/open_file_class.dart';

import 'package:sitediary/redux/eform_action.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:sitediary/ui/template/file_dialog.dart';
import 'package:sitediary/ui/template/signature_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sitediary/datas/eform_record.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'get_file_controller.dart';

class EFormFileItemWidget extends StatefulWidget {

  final EFormRecordDetail eFormRecordDetail;
  final bool canEdit;
  final Function onReceived;
  EFormFileItemWidget(this.eFormRecordDetail,this.canEdit,this.onReceived) ;

  @override
  _EFormFileItemWidgetState createState() => _EFormFileItemWidgetState();
}

class _EFormFileItemWidgetState extends State<EFormFileItemWidget> with AutomaticKeepAliveClientMixin {

  bool _isDownloading = false;
  double _progress =0;

  _showMessage( BuildContext context, String text){
    print( '_showMessage: $text , this.mounted: ${this.mounted}');
    if(!this.mounted) return;
    Scaffold.of(context)..removeCurrentSnackBar() ..showSnackBar(SnackBar(content: Text(text)));

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _getFileWidgetC(context)
    );
  }
  double _lastReportTime = 0;
  void onReceiveProgress(int received, int total){

    final tempTime = DateTime.now().millisecondsSinceEpoch / 1000;
    if (tempTime - _lastReportTime < 1 && received != total) return;
    _lastReportTime = tempTime;

    _progress = ((received * 10000 / total).round() / 100);
    widget.onReceived(this, _isDownloading, _progress);

    if (this.mounted) {
      setState(() { });
    }
  }

  void setDownloading(bool isDownload, bool isReportOnReceived){
    if (isReportOnReceived) widget.onReceived(this,isDownload, 0.0);

    if (!this.mounted) return;
    setState(() => _isDownloading = isDownload);
  }

  void _updateSignatureByteCallBack( Uint8List bytes) async{
    if (bytes==null) return;
    if (bytes.length ==0 ) {
      //Delete signature file by setting null
      _setPath(null);
      return;
    }

    final r = widget.eFormRecordDetail;
    FileCopier fc = FileCopier(r);
    fc.isForceApplicationDirectory = true;
    await fc.doCopyBytes(bytes);
    //r.itemPath =  fc.relativePath;
    final fullPath = await fc.getFullPath();
    _setPath(fullPath);
  }

  void _updateFileCallBack( String file) async{
    if (file==null) {
      //Delete file by setting null
      _setPath(null);
      return;
    }

    final r = widget.eFormRecordDetail;
    FileCopier fc = FileCopier(r);

    File fSource = File(file);
    await fc.doCopy(fSource);
    //r.itemPath =  fc.relativePath;
    final fullPath = await fc.getFullPath();
    _setPath(fullPath);
  }

  void _setPath(String fullPath){
    if (!mounted) return ;
    setState(() {
      widget.eFormRecordDetail.setFile( fullPath);
    });
  }

  void _showFileDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return FileDialog(widget.eFormRecordDetail,_updateFileCallBack);
      },
    );
  }

  void _showSignatureDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return SignatureDialog2(widget.eFormRecordDetail);
      },
    ).then((bytes){
      this._updateSignatureByteCallBack(bytes);
    });
  }

  Widget _getFileWidgetC(BuildContext context){

    Widget w = Container();
    final isSign = widget.eFormRecordDetail.isSignature;
    if (widget.canEdit) {
      w = ButtonTheme(
        minWidth: 36.0,
        height: 36.0,
        child: RaisedButton(color: Colors.blueAccent[100],
            padding: EdgeInsets.all(0),
            child: Icon(isSign ? Icons.border_color : Icons.attach_file),
            onPressed: isSign ? _showSignatureDialog : _showFileDialog
        ),
      );
    }

    return Row(
      children: <Widget>[
        w,
        isSign?_getSignView(context):
        _getFileView(context, widget.eFormRecordDetail),
      ],
    );
  }

  Future<GetFileController> getFileFuture(BuildContext context, EFormRecordDetail recordDetail, bool isBackground, bool isForceApplicationDirectory) async {
    //print('recordDetail.hasFile: ${recordDetail.hasFile}');
    if (!recordDetail.hasFile) return null;
    GetFileController fileController = new GetFileController();

    FileCopier fc = FileCopier(recordDetail);
    fc.isForceApplicationDirectory = isForceApplicationDirectory; //Sign file use app dir only

    String fileFullPath = await fc.getFullPath();

    fileController.file = File( fileFullPath);
    if (fileController.file.existsSync() ){
      if ( fileController.file.lengthSync() == 0){
        fileController.file.deleteSync();
      }else{
        fileController.isOk = true;
        fileController.file = fileController.file;
        return fileController;
      }
    }

    if((recordDetail.itemPathServer??'').isNotEmpty) {
      if (this._isDownloading) return fileController;

      print('File item getFile download begin: ${recordDetail.itemValue}');
      if(!isBackground) setDownloading(true,false);

        Store<EFormRecordState> store = StoreProvider.of<EFormRecordState>(context);
        final action1 = DownloadFileServerAction(
             onReceiveProgress, fc, StoreProvider.of<AppState>(context).state
        );
        store.dispatch(action1);

       await Future.wait([action1.completer.future]).then((resultList){
         print('File item getFile download task completed. ${recordDetail.itemValue}');
          if (!fileController.file.existsSync()){
            fileController.file = null;
            fileController.errorMsg ='File item getFile download task completed and file not exists. ${recordDetail.itemValue}';
            print(fileController.errorMsg);
            return ;
          }

          /*
          if (!isBackground && !this.mounted){
            fileController.file = null;
            fileController.errorMsg ='File item getFile download task completed and not mounted. ${recordDetail.itemValue}';
            print(fileController.errorMsg);
            return ;
          }
          */

          if (fileController.file.lengthSync() > 0){
            //isOk
            fileController.isOk = true;
            print('File item getFile download task completed and file Ok. ${recordDetail.itemValue}');
            if(!isBackground) setDownloading(false,true);
          }else{
            fileController.errorMsg ='File item getFile downloaded fail with size 0: ${recordDetail.itemValue}';
            print('${fileController.errorMsg}' );
            if(isBackground && mounted) {
              //download fail, stop auto download next time by .
              setState(() {
                recordDetail.hasFileTemp = false;
              });
            }
            fileController.file.delete();
            fileController.file = null;
          }
        }).catchError((error){
          print('DownloadFileServerAction catchError: $error');
          if(!isBackground) {
            fileController.isOk = false;
            fileController.errorMsg ='Download fail...';
          }
          fileController.file = null;
        }).whenComplete((){
          if(!isBackground) setDownloading(false,true);
          return fileController;
        });

    }


    return fileController;
  }

  _selectDateAndTime(EFormRecordDetail r , BuildContext context) async {

    DateTime sd = r.itemValueDateTime;

    if (sd == null) sd = DateTime.now();
    DateTime v = await showDatePicker(context: context,
      initialDate: DateTime(sd.year, sd.month, sd.day),
      firstDate: DateTime(sd.year - 30),
      lastDate: DateTime(sd.year + 30),);

    if (v == null) return;

    final TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: sd.hour, minute: sd.minute,),
    );

    if (t == null) return;
    v = v.add(Duration(hours: t.hour));
    v = v.add(Duration(minutes: t.minute));

    setState(() {
      r.itemValueDateTime = v;
    });

  }

  Widget _getSignDateTimeView(BuildContext context,EFormRecordDetail r ) {
    if (r.isSignatureNoDateTime) return Container();

    return Center(
      child: GestureDetector(
        child: Container(
          child: Text('${r.getDateTimeValueString}'),
          decoration: !widget.canEdit ? null : BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
        ),
          onTap: !widget.canEdit ? null : () {
            _selectDateAndTime(r, context);
          },
      ),
    );
  }

  Widget _getSignView(BuildContext context) {
    final r = widget.eFormRecordDetail;

    return Container(
      height: 120,
      child: FutureBuilder(
        future: getFileFuture(context, r, true, true),
        builder: (BuildContext context, AsyncSnapshot<GetFileController> snapshot) {

          //print('_getSignView build: ${snapshot.connectionState} ' );

          if (snapshot.connectionState != ConnectionState.done ||
              snapshot.data == null ||
              snapshot.data.file == null)
            return Container();

          return Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.file(snapshot.data.file),
                  ),
                  _getSignDateTimeView(context,r),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getFileView(BuildContext context, EFormRecordDetail r){
    return FlatButton(
      onPressed: () async {
        print('_getFileView');
        getFileFuture(context, r,false,true).then((file){
          print('_getFileView then ${file.file}');
           if (file==null) return;

           if (file.isOk) {
             OpenFileClass.open(file.file);
           }else{
             _showMessage(context, file.errorMsg);
           }
         });
      },
      child: Container(
        width: MediaQuery.of(context).size.width - (widget.canEdit?130:130),
        child: Row(
          children: <Widget>[
            _isDownloading
                ? SpinKitRing( color: Colors.redAccent[200], size: 30)
                : Icon(Icons.attach_file),
            Expanded(
              child: Text(
                _isDownloading ?' $_progress %' : '${r.itemValue??''}',
                //overflow: TextOverflow.ellipsis,
              ),
            ),
          ],

        ),
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}




