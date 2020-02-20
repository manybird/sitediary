import 'package:flutter/material.dart';

class ListButton extends StatelessWidget {
  final String text;
  final Function onClick;
  ListButton(this.text, {this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(4),
          color: Colors.grey[200], child: Text(this.text),
      ),
      onTap: () {
        if (onClick != null) onClick();
      },);
  }
}
