import 'package:flutter/material.dart';
import 'package:sitediary/ui/sitediary/editor/editor.dart';


class CheckBoxEditor extends Editor {

  final bool checked;
  final Function(bool) onCheckedChanged;
  CheckBoxEditor(this.checked,{this.onCheckedChanged,title=''})
  : super(title: title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: containerMargin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title??''),
          Checkbox(
            value: checked??false,
            onChanged: onCheckedChanged,
          ),
        ],
      ),
    );
  }
}
