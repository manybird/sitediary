import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_list_object.dart';
import 'package:sitediary/ui/sitediary/editor/text_edit_dialog.dart';

import 'editor.dart';


class ComboItemFactory{

  DropdownMenuItem<dynamic> selectedItem;
  List<DropdownMenuItem<dynamic>>  dropdownMenuItems= List();
  Function(dynamic) onSelectionChanged;
  bool canEdit=true;
  int maxLine;

  String get selectedValue{
    return (this.selectedItem?.value)?.toString();
  }
  Function(dynamic) onComboEditAdd;
  ComboItemFactory({ this.selectedItem,this.dropdownMenuItems,this.onSelectionChanged, this.maxLine=1});

  factory ComboItemFactory.init(){
    return ComboItemFactory(dropdownMenuItems: []);
  }

  Widget createDropdownButton(BuildContext context, String title){
    return Container(

      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title??''),
          Row(
              children: <Widget>[
                Expanded(
                  child:  DropdownButton(
                    itemHeight: null,
                    //itemHeight: kMinInteractiveDimension,
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    focusColor: Colors.blueAccent[100],
                    items: this.dropdownMenuItems,
                    onChanged: this.onSelectionChanged,
                    value: this.selectedItem?.value,
                  ),
                ),
                onComboEditAdd!=null ? Container(
                 child: IconButton(
                   icon: Icon(Icons.edit),
                   onPressed:(){
                     showDialog(context: context, builder: (c) {
                       return TextEditingDialog(
                         title: title,
                         defaultText: selectedValue,maxLine: maxLine,
                       );
                     }).then((result) async{
                       if (result==null) return;
                       if (result.toString()!=this.selectedValue){
                         onComboEditAdd(result);
                         if (this.onSelectionChanged!=null )
                           this.onSelectionChanged(result);
                       }
                     });
                   },
                 ),
               ):Container(),
              ],
            ),
        ],
      ),
    );

  }

  List<DropdownMenuItem> buildDropDownMenuItems(List<dynamic> oList, String defaultText,{dynamic dummyItemIfEmpty}){
    final f = this;
    for(final c in oList){

      bool isSelected = false;
      if (f.selectedItem==null && defaultText ==null){
        isSelected = true;
      }else if (c==null?'':c.toString() == defaultText??''){
        isSelected = true;
      }

      final ddi = DropdownMenuItem(
        value: c,
        child: ComboDropDownItemChild(
          f, c, isSelected,
        ),
      );

      if (f.selectedItem == null) {
        f.selectedItem = ddi;
      }else if (isSelected){
        f.selectedItem = ddi;
      }
      f.dropdownMenuItems.add(ddi);
    }

    if (f.dropdownMenuItems.length ==0 && dummyItemIfEmpty!=null)
    {
      f.selectedItem = DropdownMenuItem(
        child: ComboDropDownItemChild(f,dummyItemIfEmpty,true),
      );

      f.dropdownMenuItems.insert(0, f.selectedItem);
    }

    return f.dropdownMenuItems;
  }

}

class ComboEditor extends Editor {
  //final String title;
  final ComboItemFactory comboItemFactory;
  ComboEditor(this.comboItemFactory, {title=''})
      :super(title:title);

  @override
  Widget build(BuildContext context) {
    return comboItemFactory.createDropdownButton(context, title);
  }
}

class ComboDropDownItemChild extends StatelessWidget {

  final ComboItemFactory f;
  final SDListBase listItem;
  final String itemLabel;
  final bool isSelected;

  ComboDropDownItemChild(this.f, this.listItem,this.isSelected,{ this.itemLabel=''});

  @override
  Widget build(BuildContext context) {

    TextStyle itemTextStyle;
    double itemWidth ;// MediaQuery.of(context).size.width -80;

    itemTextStyle = Theme.of(context).textTheme.subtitle;
    itemWidth = MediaQuery.of(context).size.width -70;

    if  (f.onComboEditAdd!=null){
      itemWidth = itemWidth -30;
      //print(' listItem:$listItem, isComboEdit: $isComboEdit, itemWidth:$itemWidth');
    }

    return
        Container(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 2),
              width: itemWidth,

              margin:EdgeInsets.only(left: 6),
              child: Text(
                listItem==null?itemLabel:listItem.tText,
                style: itemTextStyle,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: isSelected? [Colors.grey[200],Colors.blueGrey[100]]: [Colors.grey[100],Colors.grey[100]],
                ) ,
                border:  Border(bottom: BorderSide(color: Colors.grey)),
            ),
              /*
              decoration: isSelected?BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors:  [Colors.grey[200],Colors.blueGrey[100]]
                  ) ,
                  border: Border(bottom: BorderSide(color: Colors.grey))
              ):null,
               */


        );
  }
}


