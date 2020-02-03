

import 'package:sitediary/ui/edit_item/form_check_list_item.dart';
import 'package:sitediary/ui/edit_item/form_checkbox_item.dart';
import 'package:sitediary/ui/edit_item/form_map_item.dart';
import 'package:sitediary/ui/template/edit_dialog.dart';
import 'package:flutter/material.dart';

import 'package:sitediary/datas/eform_item_section.dart';

import 'package:sitediary/datas/eform_record.dart';
import 'package:sitediary/ui/edit_item/form_combo_item.dart';
import 'package:sitediary/ui/edit_item/form_file_item.dart';

class RecordDetailHeaderView extends RecordDetailView {
  final EFormItemSection _eFormItemSection;

  RecordDetailHeaderView(EFormItemSectionDetail recordSectionDetail, bool isActiveSection, bool isAbleToSave, this._eFormItemSection)
      : super(recordSectionDetail, isActiveSection, isAbleToSave, null);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(left: 6, top: 2,),
      child:
      Text(
        _eFormItemSection.sectionLabel,
        style: TextStyle(fontSize:24,color: this.isActiveSection?Colors.red[400]: Colors.lightBlue[400],),
      ),
    );
  }
}

class RecordDetailView extends StatefulWidget {
  final EFormItemSectionDetail recordSectionDetail;
  final bool isActiveSection;
  final bool isAbleToSave;
  final Function onReceived;
  RecordDetailView(this.recordSectionDetail,this.isActiveSection, this.isAbleToSave, this.onReceived);

  @override
  _RecordDetailViewState createState() => _RecordDetailViewState();
}

class _RecordDetailViewState extends State<RecordDetailView> {

  _selectDateAndTime(EFormItemSectionDetail sec, BuildContext context, DateTime sd) async {

    EFormRecordDetail r = sec.recordDetail ;

    DateTime v = await showDatePicker(context: context,
      initialDate: DateTime(sd.year, sd.month, sd.day),
      firstDate: DateTime(sd.year - 30),
      lastDate: DateTime(sd.year + 30),);

    if (v == null) return;

    final TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: sd.hour, minute: sd.minute,),
    );

    if (t == null) return;
    v = v.add(Duration(hours: t.hour));
    v = v.add(Duration(minutes: t.minute));

    setState(() {
      r.itemValueDateTime = v;
    });

  }

  Widget _getEditView(EFormItemSectionDetail sectionDetail, BuildContext context, bool canEdit) {

    EFormRecordDetail r = sectionDetail.recordDetail;

    final textStyle = Theme .of(context) .textTheme .subtitle;

    Widget w = Text('${r.getValue ?? ''}', style: textStyle,);
    if (r.isDate){
      if (r.isDateTimeNowIfEmpty && r.itemValueDateTime ==null && canEdit){
        r.itemValueDateTime = DateTime.now();
        w = Text('${r.getValue ?? ''}', style: textStyle,);
      }
    } else if (r.isCheckBox) {
      w = EFormCheckBoxItemWidget(r, canEdit,_createLabel);
    } else if (r.isFile) {
      w = EFormFileItemWidget(r, canEdit, widget.onReceived);
    } else if (r.isCombo && r.valuesOptionObject != null) {
      if (canEdit)
        w = EFormComboItemWidget(sectionDetail, canEdit);
    }else if (r.isCheckListItem && r.valuesOptionObject != null) {
        w = EFormCheckListItemWidget(sectionDetail, canEdit);
    }else if (r.isMap) {
      w = EFormMapItemWidget(sectionDetail, canEdit);
    }
    return w;
  }

  Widget _createLabel(String s, double paddingTop){
    return    Container(
      padding: EdgeInsets.only(top:paddingTop),
      child: Text(        
        s,     
        style: TextStyle(
          fontStyle:  Theme.of(context).textTheme.subhead.fontStyle,
          color: Colors.black45,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final section =widget.recordSectionDetail;

    final r = section.recordDetail;
    if (r==null) return Container();
    bool isReadOnly = r.isReadOnly;

    bool canEdit = !isReadOnly && this.widget.isAbleToSave && this.widget.isActiveSection;

    List<Widget> list = List();

    list.add(
        _createLabel('${r.itemLabel??r.eFormItemKey}',8)
    );

    bool isSpecialItem = (r.isFile || r.isCombo|| r.isCheckBox || r.isCheckListItem || r.isMap);

    bool hideEditBottomLine = (isReadOnly || isSpecialItem);

    list.add(
      Container(
        padding: EdgeInsets.only(top: 1, left: 8),
        margin: EdgeInsets.only(left: 6),
        width: MediaQuery.of(context).size.width ,
        child: _getEditView(section,context ,canEdit),
        decoration:   BoxDecoration(
          border: hideEditBottomLine?null:Border(
              bottom: BorderSide(color: Colors.black54)
          ),
        ),
      )
    );

    if ((r.itemSubLabel??'').isNotEmpty && !r.isCheckBox){
      list.add(
        _createLabel(r.itemSubLabel,0)
      );
    }


    return  GestureDetector(
      onTap: !canEdit?null:() {
        if (r.isDate)
        {
          DateTime d = r.itemValueDateTime;
          if (d == null) d = DateTime.now();
          _selectDateAndTime(section, context, d);
        }
        else if (isSpecialItem)
        {
          return;
        }
        else {
          showDialog(context: context, builder: (c) {
            return RecordDetailEditingDialog(r);
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6,horizontal: 3),
        margin: EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
        decoration: BoxDecoration(
          //border: isReadOnly?null:Border.all(color: Colors.black26),
          //borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),

    );
  }

}





