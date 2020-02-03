
import 'package:sitediary/datas/eform_item_section.dart';
import 'package:sitediary/ui/template/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sitediary/datas/eform_item.dart';



class EFormComboItemWidget extends StatefulWidget {

  final EFormItemSectionDetail sectionDetail ;
  final bool canEdit;

  EFormComboItemWidget(this.sectionDetail,this.canEdit);

  @override
  _EFormComboItemWidgetState createState() => _EFormComboItemWidgetState();
}

class _EFormComboItemWidgetState extends State<EFormComboItemWidget> {

  Widget _getComboWidget( BuildContext context){
    final r  =widget.sectionDetail.recordDetail;

    final canEdit = widget.canEdit;
    final textStyle = Theme.of(context).textTheme.subtitle;
    double width = MediaQuery.of(context).size.width -80;
    if (!r.valuesOptionObject.isSingle ) width = width - 100;

    if (r.isComboEdit && canEdit) width = width - 40;

    if ( (r.itemValue??'').isNotEmpty && !r.valuesOptionObject.containInList(r.itemValue)){
        r.valuesOptionObject.addToList(r.itemValue);
    }

    List<DropdownMenuItem<EFormItemValuesOptionItem>> dropdownMenuItems = List();
    for(final item in r.valuesOptionObject.list) {
      dropdownMenuItems.add(DropdownMenuItem(
        value: item,
        child: Container(
            width: width,
            child: Text(
              item.t,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            )
        ),
      )
      );
    }


    final initItem = r.valuesOptionObject.getItemByValue(r.itemValue);

    if (initItem.v!=r.itemValue){
      r.itemValue = initItem.v;
    }

    Widget outWidget = Flexible(
      fit: FlexFit.loose,
      child: Container(
        padding: EdgeInsets.only(right: 1),
        child: DropdownButton(
          items: dropdownMenuItems,
          onChanged: (EFormItemValuesOptionItem v){
            if (!canEdit) {
              setState(() { r.itemValue =initItem.v; });
            }else {
              setState(() { r.itemValue =v.v; });
            }
          },
          value: initItem,
        ),
      ),
    );

    final outList = List<Widget>();

    outList.add(outWidget);

    if (!r.valuesOptionObject.isSingle){
      outList.add(
          Container(
            child: Text(
              '${r.itemValue}',
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
            width: 100,
          )
      );
    }

    if (r.isComboEdit && canEdit){
      outList.add(IconButton(icon: Icon(Icons.mode_edit), onPressed: (){
        showDialog(context: context, builder: (c) {
          return RecordDetailEditingDialog(r);
        });
      }));
    }

    outWidget = Row(
      children: outList,
      mainAxisAlignment: MainAxisAlignment.start,
    );

    return outWidget;
  }

  @override
  Widget build(BuildContext context) {
    return _getComboWidget(context);
  }
}