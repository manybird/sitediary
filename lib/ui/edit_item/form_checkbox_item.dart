
import 'package:flutter/material.dart';
import 'package:sitediary/datas/eform/eform_record.dart';


class EFormCheckBoxItemWidget extends StatefulWidget {

  final EFormRecordDetail r ;
  final bool canEdit;
  final Function createLabelFunction;

  EFormCheckBoxItemWidget(this.r,this.canEdit,this.createLabelFunction);

  @override
  _EFormCheckBoxItemWidgetState createState() => _EFormCheckBoxItemWidgetState();
}

class _EFormCheckBoxItemWidgetState extends State<EFormCheckBoxItemWidget> {

  @override
  Widget build(BuildContext context) {

    final r = widget.r;

    bool isChecked = (r.itemValue??'') !='';
    final cb = Checkbox(
        value: isChecked,
        onChanged:! widget.canEdit?null: (bool b){
          r.itemValue = b?'1':'';
          setState(() { });
        }
    ) ;

    final l = List<Widget>();
    l.add(cb);

    if ((r.itemSubLabel??'').isNotEmpty){
      l.add(
          Flexible(child: widget.createLabelFunction(r.itemSubLabel,0.0))
      );
    }

    return Row(children: l);
  }
}