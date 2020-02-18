import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_list_object.dart';


class ComboItemFactory{

  DropdownMenuItem<dynamic> initItem;
  List<DropdownMenuItem<dynamic>>  dropdownMenuItems= List();
  Function(dynamic) onSelectionChanged;
  bool canEdit=true;
  String title;

  Function onComboEditPress;

  ComboItemFactory(this.title, { this.initItem,this.dropdownMenuItems,this.onSelectionChanged});

  factory ComboItemFactory.init(String title){
    return ComboItemFactory(title,dropdownMenuItems: []);
  }

  Widget createDropdownButton(context){



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
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    focusColor: Colors.blueAccent[100],
                    items: this.dropdownMenuItems,
                    onChanged: this.onSelectionChanged,
                    value: this.initItem?.value,
                  ),

              ),
              onComboEditPress!=null ? Container(
               child: IconButton(
                 icon: Icon(Icons.edit),
                 onPressed: onComboEditPress,
               ),
             ):Container(),
            ],
          ),
        
      ],),
    );

  }
}

class ComboItem extends StatefulWidget {
  final ComboItemFactory comboItemFactory;
  ComboItem(this.comboItemFactory);
  @override
  _ComboItemState createState() => _ComboItemState();
}

class _ComboItemState extends State<ComboItem> {
  @override
  Widget build(BuildContext context) {
    final f = widget.comboItemFactory;
    return f.createDropdownButton(context);
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
    itemWidth = MediaQuery.of(context).size.width -80;

    if  (f.onComboEditPress!=null){
      itemWidth = itemWidth -40;
      //print(' listItem:$listItem, isComboEdit: $isComboEdit, itemWidth:$itemWidth');
    }

    return
        Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
            width: itemWidth,
            margin:EdgeInsets.only(left: 10),
            child: Text(
               listItem==null?itemLabel:listItem.tText, overflow: TextOverflow.ellipsis,
              style: itemTextStyle,
            ),
            decoration: isSelected?BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.grey[200],Colors.blueGrey[100]]
                ) ,
                border: Border(bottom: BorderSide(color: Colors.grey))
            ):null,


        );
  }
}


