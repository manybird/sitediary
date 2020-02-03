import 'dart:io';

import 'package:sitediary/datas/eform_record.dart';
import 'package:sitediary/persistence/open_file_class.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class FormReportItem  extends StatefulWidget {


  final EFormRecord eformRecord;
  final Function onProgress;
  FormReportItem(this.eformRecord,this.onProgress);

  @override
  _FormReportItemState createState() => _FormReportItemState();
}

class _FormReportItemState extends State<FormReportItem> {

  double _lastReportTime = 0;
  double _progress =0;
  bool _isProcessing = false;
  void onReceiveProgress(int received, int total){

    final tempTime = DateTime.now().millisecondsSinceEpoch /1000;
    if (tempTime - _lastReportTime < 1 && received != total) return;

    if (this.mounted){
      final temp = ((received * 10000 / total).round() / 100);
      print('onReceiveProgress: $received, $total');

      _progress = temp;
      _lastReportTime = tempTime;

    }
    widget.onProgress(this,true,_progress);
  }

  void reportProgress(bool isProcessing, double progress){
    _isProcessing = isProcessing;
    _progress = progress;
    widget.onProgress(this,_isProcessing,_progress);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(

      onPressed: (){

        if (_isProcessing) return;
        print('Download report here...');

        reportProgress(true,0);
        Future.delayed(Duration(seconds: 1)).then((v)  {
          if (!this.mounted) return;
          Store<EFormRecordState> store = StoreProvider.of<EFormRecordState>(context);
          final action1 = DownloadReportServerAction(
              widget.eformRecord, onReceiveProgress, StoreProvider.of<AppState>(context).state
          );
          store.dispatch(action1);

          Future.wait([action1.completer.future]).then(( a) async{

            File file =  a[0];
            if (file.existsSync()){
              file.length().then((length){
                if (this.mounted) {
                  if (length > 0){
                    OpenFileClass.open(file);
                  }else{
                    file.delete();
                  }
                }
              });
            }
          }).catchError((error){
            print('DownloadFileServerAction catchError: $error');
            reportProgress(false,_progress);
          }).whenComplete((){
            reportProgress(false,_progress);
          });
        });

      },
      icon: Icon(
        Icons.picture_as_pdf,
      ),
    );
  }


}
