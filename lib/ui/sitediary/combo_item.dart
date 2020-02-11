import 'package:flutter/material.dart';


class ComboItemFactory{

  DropdownMenuItem<Object> initItem;
  List<DropdownMenuItem<Object>>  dropdownMenuItems= List();
  Function onChange;
  bool canEdit=true;
  String label;

  ComboItemFactory({this.initItem,this.dropdownMenuItems,this.onChange});

  Widget createDropdownButton(){

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Text(label),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            padding: EdgeInsets.only(right: 1),
            child: DropdownButton(
              underline: Container(
                height: 0,
                color: Colors.deepPurpleAccent,
              ),
              focusColor: Colors.blueAccent[100],
              /*
              selectedItemBuilder: (context){
                return dropdownMenuItems.map<Widget>((DropdownMenuItem item) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                    ),
                      child: Text(item.value.tText),
                  );
                }).toList();
              },
               */
                items: this.dropdownMenuItems,
                onChanged: this.onChange,
                value: this.initItem?.value,

            ),
          ),
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
    return f.createDropdownButton();
  }
}

class ComboDropDownItemChild extends StatelessWidget {

  final String t;
  final bool isSelected;

  ComboDropDownItemChild(this.t,this.isSelected);

  @override
  Widget build(BuildContext context) {

    TextStyle itemTextStyle;
    double itemWidth ;// MediaQuery.of(context).size.width -80;

    itemTextStyle = Theme.of(context).textTheme.subtitle;
    itemWidth = MediaQuery.of(context).size.width -80;

    return Container(
      padding: EdgeInsets.all(8),
      width: itemWidth,
      margin:EdgeInsets.only(left: 10),
      child: Text(
        t, overflow: TextOverflow.ellipsis,
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


