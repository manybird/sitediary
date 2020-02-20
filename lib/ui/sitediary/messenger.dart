import 'package:flutter/material.dart';

 class Messenger{

  static show(BuildContext context, String text){
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}