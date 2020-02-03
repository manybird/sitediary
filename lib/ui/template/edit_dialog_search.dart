import 'package:sitediary/datas/eform.dart';
import 'package:sitediary/datas/user.dart';
import 'package:flutter/material.dart';

import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


class RecordDetailEditingDialogSearch extends StatelessWidget {

  final bool isFirstValue;
  final EFormItemSearch itemSearch;
  final UserSearchOption searchOption;
  RecordDetailEditingDialogSearch(this.searchOption,this.itemSearch,this.isFirstValue);

  final TextEditingController textEditingController = TextEditingController();

  Widget _getTextFieldWidget(){
    return TextField(controller: textEditingController,
      autofocus: true,
    );
  }

  Widget _getEditWidget(UserSearchOption r) {
    String v = searchOption.searchText;

    if (itemSearch!=null){
      if (isFirstValue) v = itemSearch.v1 ;
      else v = itemSearch.v2;
    }

    v = v??'';

    textEditingController.value =
        TextEditingValue(
          text:v,
          selection: TextSelection.collapsed(offset: v.length),
        );

    return _getTextFieldWidget();
  }

  @override
  Widget build(BuildContext c) {
    final r = searchOption;



    String lb = '${itemSearch==null?'':itemSearch.itemLabel}';

    if (itemSearch!=null && itemSearch.isRangeSearch){
      if (isFirstValue){
        lb = lb + ' from';
      }else{
        lb = lb + ' to';
      }
    }

    return AlertDialog(
      content:  Container(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              lb,
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


                  final userInput = textEditingController.text;
                  if (itemSearch ==null)
                  {
                    r.searchText = userInput;
                  }else{

                    if (isFirstValue){
                      itemSearch.v1 = userInput;
                    }else{
                      itemSearch.v2 = userInput;
                    }

                    r.itemSearchList.clear();
                    r.itemSearchList.add(itemSearch);
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