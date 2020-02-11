

import 'package:sitediary/datas/eform/eform.dart';
import 'package:sitediary/datas/eform/eform_item.dart';
import 'package:sitediary/datas/user.dart';
import 'package:sitediary/redux/actions.dart';
import 'package:sitediary/redux/eform/state_eform.dart';

import 'package:sitediary/redux/state_app.dart';
import 'package:sitediary/ui/template/edit_dialog_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SearchingDialog extends StatefulWidget {
  final UserSearchOption userSearchOption;
  final List<EFormItemSearch> availableItemSearchList;
  SearchingDialog(this.userSearchOption, this.availableItemSearchList);

  @override
  __SearchingDialogState createState() => __SearchingDialogState();
}

class __SearchingDialogState extends State<SearchingDialog> with AutomaticKeepAliveClientMixin {

  //TextEditingController textEditingController;// = TextEditingController();

  _selectDate(BuildContext context, EFormItemSearch searchItem,  bool isFirstValue) async {

    DateTime sd = searchItem.getValue(isFirstValue);

    DateTime v = await showDatePicker(
      context: context,
      initialDate: sd,
      firstDate: DateTime(sd.year - 30),
      lastDate: DateTime(sd.year + 30),
    );

    if (v == null) return;

    setState(() {
      searchItem.setValue(v, isFirstValue);

      if (searchItem.isRangeSearch){

      }

    });

  }

  Widget _getTextEditWidget(BuildContext context,UserSearchOption searchOption, EFormItemSearch searchItem, bool isFirstValue) {

    String s = searchOption.searchText ?? '';
    String fieldLabel = '';
    double fieldLabelWidth = 2;
    bool isDate=false;
    //textEditingController.value = TextEditingValue(      text: s, selection: TextSelection.collapsed(offset: s.length));

    if (searchItem!=null){
      isDate = searchItem.isDate;
      fieldLabelWidth = 40;
      if (isFirstValue){
        if (searchItem.isRangeSearch){
          fieldLabel = 'From: ';
        }else{
          fieldLabelWidth = 10;
        }

        s = searchItem.v1;
      }else{
        fieldLabel = 'To: ';
        s = searchItem.v2;
      }
    }

    return Container(
      padding: EdgeInsets.all(4.0),

      child: Row(
        children: <Widget>[
          Container(
            width: fieldLabelWidth,
              child: Text(fieldLabel)
          ),
          GestureDetector(
            onTap: (){

              if (isDate){
                _selectDate(context, searchItem,isFirstValue);
              }
              else{
                showDialog(context: context, builder: (c) {
                  return RecordDetailEditingDialogSearch(searchOption,searchItem,isFirstValue);
                });
              }

            },
            child: Container(
                width: MediaQuery.of(context).size.width -60 -fieldLabelWidth,
                margin: EdgeInsets.all(4),
                child: Container(
                    margin: EdgeInsets.all(4),
                    child: Text(s??'')
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200])
                  ),
                ),
            ),
          ),
        ],
      ),
      //TextField(controller: textEditingController, autofocus: true,),
    );
  }

  Widget _getButtons(BuildContext context,UserSearchOption searchOption){
    Store<AppState> store = StoreProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              //textEditingController.text = '';
              widget.userSearchOption.resetValues();
              store.dispatch(UserDoSearchAction(searchOption));
              return Navigator.of(context).pop(false);
            },
            child:  Text("Reset"),
          ),
          RaisedButton(
            onPressed: () {

              final so = widget.userSearchOption;

              store.dispatch(UserDoSearchAction(so));
              return Navigator.of(context).pop(true);
            },
            child:  Text("Ok"),
          ),
        ],
      ),
    );
  }

  Widget _getSortingWidget(BuildContext context,UserSearchOption searchOption){

    Store<EFormState> store = StoreProvider.of(context);
    final textStyle = Theme.of(context).textTheme.subtitle;
    final width = MediaQuery.of(context).size.width;
    List<DropdownMenuItem<EFormItem>> dropdownMenuItems = List();
    final f = store.state.currentEForm;
    for(final item in f.sortableItemList) {
      dropdownMenuItems.add(DropdownMenuItem(
        value: item,
        child: Container(
            width:  width - 150,
            child: Text(
              item.itemLabel,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            )
        ),
      )
      );
    }

    EFormItem initItem = f.getEFormItemByItemKey(searchOption.sortingColumnItemKey);

    return Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          DropdownButton(
            items: dropdownMenuItems,
            onChanged: (EFormItem v){
              setState(() {
                searchOption.setSortingColumn(v.eFormItemKey,v.isDate);
              });
            },
            value: initItem,
          ),
          IconButton(
            color: Colors.redAccent[200],
            icon: Icon(
                widget.userSearchOption.sortingType=='asc'
                    ?Icons.arrow_upward
                    :Icons.arrow_downward
            ),
            onPressed: (){
              setState(() {
                if (widget.userSearchOption.sortingType=='asc'){
                  widget.userSearchOption.sortingType='desc';
                }else{
                  widget.userSearchOption.sortingType='asc';
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _createLabel(String t){
    return Padding(
      padding: EdgeInsets.only(left:8, top: 8),
      child: Text(
        t,
        style: TextStyle(
          fontStyle:  Theme.of(context).textTheme.subhead.fontStyle,
          color: Colors.black45,
        ),
      ),
    );
  }


  Widget _getAdvSearchWidget(BuildContext context,UserSearchOption searchOption){

    EFormItemSearch initItem;

    final list = widget.availableItemSearchList;
    EFormItemSearch _itemSearch ;

    if (searchOption.itemSearchList ==null)
      searchOption.itemSearchList = List<EFormItemSearch>();
    else if (searchOption.itemSearchList.length > 0){
      _itemSearch = searchOption.itemSearchList[0];
    }

    double width = MediaQuery.of(context).size.width -100;

    List<DropdownMenuItem<EFormItemSearch>> dropdownMenuItems = List();

    final emptyItem = EFormItemSearch.empty();

    if (list.length == 0 ){
      list.insert(0, emptyItem);
    }else {
      if (list[0].itemLabel.isNotEmpty){
        list.insert(0, emptyItem);
      }
    }




    for(final item in list) {
      dropdownMenuItems.add(
          DropdownMenuItem(
            value: item,
            child: Container(
                width: width,
                child: Text(
                  item.itemLabel,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle,
                )
            ),
          )
      );
    }


    if (_itemSearch!=null){
      for(final i in list) {
        if (i.eFormItemKey == _itemSearch.eFormItemKey) {
          initItem = i;
          break;
        }
      }
    }

    if (initItem ==null) initItem = emptyItem;

    List<Widget> wList = List();

    wList.add(
      Container(
        margin: EdgeInsets.all(4),
        child: DropdownButton(
          items: dropdownMenuItems,
          onChanged: (EFormItemSearch v){
            setState(() {
              initItem = v;

              if (initItem.isDate){
                initItem.v1 = initItem.getValueForDateAsString(true);
                initItem.v2 = initItem.getValueForDateAsString(false);
              }else{
                initItem.v1 = '';
                initItem.v2 = '';
              }

              searchOption.itemSearchList.clear();
              searchOption.itemSearchList.add(initItem);
            });
          },
          value: initItem,
        ),
      ),
    );


    if (initItem.itemLabel.isEmpty){
    }else {
      wList.add( _getTextEditWidget(context, searchOption,initItem,true));
      if (initItem.isRangeSearch){
        wList.add(_getTextEditWidget(context, searchOption,initItem,false));
      }
    }

    return Container(
      child: Column(
        children: wList,
      )
    );

  }

  Widget _mainContext(BuildContext context,UserSearchOption searchOption){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createLabel('Search: '),
          _getTextEditWidget(context, searchOption,null,false),
          _createLabel('Sorting: '),
          _getSortingWidget(context,searchOption),

          _createLabel('Field search: '),
          _getAdvSearchWidget(context, searchOption),

          _getButtons(context,searchOption),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    //textEditingController = TextEditingController();
    //textEditingController.addListener((){ widget.userSearchOption.searchText = textEditingController.text;});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    final pd = MediaQuery.of(context) .viewInsets + const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0);

    return AnimatedPadding(
      padding: pd,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Material(
              elevation: 24.0,
              color: Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
              child: _mainContext(context,widget.userSearchOption),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
