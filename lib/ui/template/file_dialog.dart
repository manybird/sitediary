import 'dart:io';
import 'package:sitediary/ui/template/self_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sitediary/datas/eform_record.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sitediary/ui/template/confirm_dialog.dart';


class FileDialog extends StatelessWidget {

  final EFormRecordDetail eFormRecordDetail;
  final Function updateFileCallBackC;
  FileDialog(this.eFormRecordDetail, this.updateFileCallBackC);

  bool updateFileCallBack( BuildContext context, String file){
    updateFileCallBackC(file);
    return Navigator.of(context).pop(true);
  }

  Future _openFileExplorer(BuildContext context,FileType _pickingType) async {

    String _path;
    Map<String, String> _paths; //multiple file support.
    String _extension;
    bool _multiPick = false;
    bool _hasValidMime = false;


    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(type: _pickingType, fileExtension: _extension);
        } else {
          _paths = null;
          _path = await FilePicker.getFilePath(type: _pickingType, fileExtension: _extension);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (_path==null &&_paths==null) return;

      updateFileCallBack(context,_path);
    }
  }

  Future getImageFromCamera(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image==null) return ;
    //setState(() => widget.eFormRecordDetail.setFile(image.path));
    updateFileCallBack(context, image.path);
  }

  @override
  Widget build(BuildContext context) {
print('file_dialog build');
    return AlertDialog(
      content:  Container(
        height: 160,
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${eFormRecordDetail.itemLabel??''}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaiseSelfIconTextButton(
                    Icons.camera_enhance,
                    'Camera',
                    onPressed: (){
                      getImageFromCamera(context);
                    },
                  ),
                  RaiseSelfIconTextButton(
                    Icons.folder,
                    'File',
                    onPressed: (){
                      _openFileExplorer(context,null);
                    },
                  ),
                  RaiseSelfIconTextButton(
                    Icons.photo,
                    'Photo',
                    onPressed: (){
                      _openFileExplorer(context,FileType.IMAGE);
                    },
                  ),
                ],
              ),

                  !eFormRecordDetail.hasFile
                      ? Container()
                      : RaiseSelfIconTextButton(Icons.delete, 'Delete', iconColor: Colors.red,
                      onPressed: (){
                        showDialog( context: context,builder: (BuildContext context){
                          return ConfirmDialog('Delete?');
                        }).then((b){
                          if (!b) return;
                          updateFileCallBack(context, null);
                        });
                     }),

            ],
          ),
        ),
        decoration:  BoxDecoration(
          //border: Border.all(color: Colors.black38),
        ),
      ),

      actions: <Widget>[
        FlatButton(
          onPressed: () {
            return Navigator.of(context).pop(false);
          },
          child:  Text("Close"),
        ),
      ],);
  }
}