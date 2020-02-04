import 'package:sitediary/datas/eform/eform_record.dart';
import 'package:flutter/material.dart';

import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


class RecordDetailEditingDialog extends StatelessWidget {

  final EFormRecordDetail _recordDetail;
  RecordDetailEditingDialog(this._recordDetail);

  final TextEditingController textEditingController = TextEditingController();

  Widget _getTextFieldWidget(){
    return TextField(controller: textEditingController,
      autofocus: true,
    );
  }

  Widget _getEditWidget(EFormRecordDetail r) {
    String v = r.itemValue??'';

    textEditingController.value =
        TextEditingValue(
          text:v,
          selection: TextSelection.collapsed(offset: v.length),
        );

    String itemType = r.itemType;
    if (itemType == null) {
      // return _getTextFieldWidget();
    }
    else if (itemType == 'DateTime') {
      textEditingController.text ='${ r.itemValueDateTime}';
      //return _getTextFieldWidget();
    }
    return _getTextFieldWidget();
  }

  @override
  Widget build(BuildContext c) {
    final r =_recordDetail;
    return AlertDialog(
      content:  Container(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${r.itemLabel??r.eFormItemKey} : ',
              style: TextStyle(
                fontStyle:  Theme.of(c).textTheme.subhead.fontStyle,
                color: Colors.black45,
              ),
            ),
            _getEditWidget(r),
          ],
        ),
        decoration:  BoxDecoration(
          //border: Border.all(color: Colors.black38),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            return Navigator.of(c).pop(false);
          },
          child:  Text("Cancel"),
        ),
        StoreConnector<AppState, Store<AppState>>(
            converter: (Store<AppState> store) {
              return  store;
            },
            builder: (BuildContext context, Store<AppState> store) {
              return FlatButton(
                onPressed: () {

                  r.itemValue = textEditingController.text;
                  if (r.isComboEdit)
                  {
                    r.valuesOptionObject.addToList(r.itemValue);
                  }

                  //store.dispatch(UpdateFormItemDetailAction(_recordSectionDetail.recordDetail));
                  return Navigator.of(c).pop(false);
                },
                child:  Text("Ok"),
              );
            }
        ),
      ],);
  }
}