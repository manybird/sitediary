import 'package:sitediary/datas/eform_item_section.dart';
import 'package:sitediary/ui/template/confirm_dialog.dart';
import 'package:flutter/material.dart';

class EditActionBar extends StatelessWidget {

  final bool _isProcessing;
  final Function doSave;
  final List<EFormItemSectionAction> currentActionList;
  final List<EFormItemSectionAction> actionListPrivate;

  EditActionBar(this._isProcessing,this.doSave,this.currentActionList,this.actionListPrivate);

  @override
  Widget build(BuildContext context) {
    return _buildActionBar(context);
  }

  Widget _buildSaveButton(BuildContext context, ThemeData themeData  ){

    final doSaveFunction = currentActionList.length > 0 && !_isProcessing ? () {
      return doSave(context , null, false);
    } : null;

    final c = currentActionList.length > 0 ? themeData.accentColor : themeData.disabledColor;

    final saveButton = Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      child: GestureDetector(
        onTap: doSaveFunction,
        child: Container(
          decoration: BoxDecoration(
            border:Border.all(color: Colors.black26),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow[100],
                blurRadius: 10.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  0.0, // vertical, move down 10
                ),
              )
            ],
          ),

          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(2),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.save, size: 34, color: c,
              ),
              Text('Save '),
            ],
          ),

        ),
      ),
    );

    return saveButton;
  }

  Widget _buildActionButton(BuildContext context, EFormItemSectionAction a, isPrivateAction){
    //EFormItemSectionAction a = currentActionList[i];
    return Container(
      padding: EdgeInsets.all(5),
      child: RaisedButton(
        onPressed: _isProcessing?null:(){

          showDialog(
              context: context,
              builder: (BuildContext context){
                return ConfirmDialog(a.actionLabel);
              }
          ).then((b){
            if (!b) return;

            doSave(context , a, isPrivateAction);
          });

        },
        child: Text(a.actionLabel),
        color: isPrivateAction?Colors.lightBlue[200]:Colors.grey[200],
      ),
    );
  }

  Widget _buildActionBar(BuildContext context) {
    final actionWidgetList = currentActionList.map((f) {
      return _buildActionButton(context, f, false);
    }).toList();

    for (int i=0;i<actionListPrivate.length;i++){
      final a = actionListPrivate[i];
      actionWidgetList.add( _buildActionButton(context,a,true));
    }

    ThemeData themeData = Theme.of(context);

    final width = MediaQuery.of(context).size.width -2;
    return IconTheme(data: IconThemeData(color: themeData.accentColor),
      child: Container(

        child: Row(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: actionWidgetList,
                ),
              ),
              width: width -100,
            ),
            _buildSaveButton(context, themeData),
          ]
        ),
      ),
    );
  }
}
