import 'package:flutter/material.dart';

class TextEditingDialog extends StatelessWidget {

  final String title;
  final String defaultText;
  final int maxLine;

  TextEditingDialog({this.title='',this.defaultText='', this.maxLine=1});
  final TextEditingController textEditingController = TextEditingController();

  Widget _getEditWidget() {
    String v = defaultText??'';

    textEditingController.value =
        TextEditingValue(
          text:v,
          //selection: TextSelection.collapsed(offset: v.length),
          selection: TextSelection(baseOffset:0, extentOffset: v.length,),
          composing: TextRange.collapsed(v.length),
        );

    textEditingController.text = v;
    return TextField(
      controller: textEditingController,
      autofocus: true,
      maxLines: maxLine,
    );
  }

  @override
  Widget build(BuildContext c) {
    //final r =_recordDetail;
    return AlertDialog(
      content:  Container(
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title==''?Container():Text(
              '$title : ',
              style: TextStyle(
                fontStyle:  Theme.of(c).textTheme.subhead.fontStyle,
                color: Colors.black45,
              ),
            ),
            _getEditWidget(),
          ],
        ),
        decoration:  BoxDecoration(
          //border: Border.all(color: Colors.black38),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            return Navigator.of(c).pop(null);
          },
          child:  Text("Cancel"),
        ),
        FlatButton(
          onPressed: () {
            return Navigator.of(c).pop(textEditingController.text);
          },
          child:  Text("Ok"),
        ),
      ],);
  }
}