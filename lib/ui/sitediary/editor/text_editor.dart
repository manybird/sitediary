import 'package:flutter/material.dart';
import 'package:sitediary/ui/sitediary/editor/editor.dart';
import 'package:sitediary/ui/sitediary/editor/text_edit_dialog.dart';

class TextEditor extends Editor {
  final String text;
  final bool canEdit=true;
  final int maxLine;
  final Function(String) onTextChanged;

  TextEditor(this.text ,{this.onTextChanged , title='', this.maxLine=1})
      :super(title:title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  containerMargin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title??''),
          Container(
            margin: EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 1, left: 8),
                  margin: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width ,
                  decoration:   BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey)
                    ),
                  ),
                  child: Text(
                    text??'', style: Theme .of(context) .textTheme .subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: maxLine,
                  ),
                ),
                onTap: (){
                  showDialog(context: context, builder: (c) {
                    return TextEditingDialog(
                      title: title,
                      defaultText: this.text,maxLine: maxLine,
                    );
                  }).then((result) async{
                    if (result==null) return;
                    if (result.toString()!=this.text){
                      onTextChanged(result);
                    }
                  });
                },
              ),

            )


        ],),
    );
  }
}
