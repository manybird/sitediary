
import 'package:sitediary/datas/eform_item_section.dart';
import 'package:sitediary/datas/eform_record.dart';
import 'package:flutter/material.dart';


class EFormCheckListItemWidget extends StatefulWidget {

  final EFormItemSectionDetail sectionDetail ;
  final bool canEdit;

  EFormCheckListItemWidget(this.sectionDetail,this.canEdit);

  @override
  _EFormCheckListItemWidgetState createState() => _EFormCheckListItemWidgetState();
}

class _EFormCheckListItemWidgetState extends State<EFormCheckListItemWidget> {

  Widget _getCheckListWidget( BuildContext context){
    final r  =widget.sectionDetail.recordDetail;
    final option1 = r.itemOption1??'10';
    int itemLengthFromOption1 = int.tryParse(option1);

    double width = MediaQuery.of(context).size.width -80;
    if (!r.valuesOptionObject.isSingle ) width = width - 100;

    String iValueFull = r.itemValue;
    if (iValueFull==null) iValueFull = r.defaultValue;
    else if (iValueFull.isEmpty) iValueFull = r.defaultValue;

    String defaultValue = ' ';

    if (r.valuesOptionObject.list.length >0){
      defaultValue = r.valuesOptionObject.list[0].v;
    }

    final itemWidgetList = List<Widget>();
    for (int i=0;i<itemLengthFromOption1;i++){

      while (i >= iValueFull.length){
        iValueFull = iValueFull + defaultValue;
      }

      final v = iValueFull[i];
      if ( v.isNotEmpty && !r.valuesOptionObject.containInList(v)){
        r.valuesOptionObject.addToList(v);
      }

      Widget itemWidget =  _createButton2(r, i, v);

      itemWidgetList.add(itemWidget);
    }

    r.itemValue = iValueFull;

    return Container(
      width: width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: itemWidgetList,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }

  Widget _createButton2( EFormRecordDetail r, int index, String v){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.only(right: 6),

        decoration: BoxDecoration(
          //border: Border.all(),
          color:widget.canEdit?Colors.blue[50]: Colors.grey[200],
          border: Border.all(color: Colors.black26, width: 1.0),
          borderRadius: BorderRadius.circular(3.0),
        ),
        height: 28,
        width: 24,
        child: Center(
          child: Text(
            v,
            style: TextStyle(fontSize: 21,fontFamily: 'MingLiU'),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: !widget.canEdit?null: () {

        final item = r.valuesOptionObject.getNextItemInList(v);
        if (item == null) {
          print('item == null, v: $v, index: $index, r.itemValue: ${r.itemValue}');
          return;
        }

        String iValueFull = r.itemValue;
        int valueLength = item.v.length;
        int a1 = index - valueLength +1;
        int a2 = index + valueLength;

        if (a1 >= 0 && a2 <= iValueFull.length) {
          final f1 =iValueFull.substring(0, a1);
          final f2 =iValueFull.substring(a2);
          iValueFull = f1 + item.v + f2;
        }

        setState(() {
          r.itemValue = iValueFull;
        });

      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return _getCheckListWidget(context);
  }
}