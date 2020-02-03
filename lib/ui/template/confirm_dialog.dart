import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {

  final String mainText;
  ConfirmDialog(this.mainText);

  @override
  Widget build(BuildContext c) {

    return AlertDialog(
      content:  Container(
        height: 40,
        child:Center(
          child: Text('$mainText?',
            style: TextStyle(color: Colors.redAccent[200]),
          ),
        ),
        decoration:  BoxDecoration(
          //border: Border.all(color: Colors.black38),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            return Navigator.of(c).pop(false);
          },
          child:  Text("No"),
        ),
        FlatButton(
          onPressed: () {
            return Navigator.of(c).pop(true);
          },
          child:  Text("Yes"),
        ),
      ],);
  }
}