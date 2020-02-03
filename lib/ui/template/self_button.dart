import 'package:flutter/material.dart';

class RaiseSelfIconTextButton extends StatelessWidget {

  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final String iconText;
  final double width;
  final double height;
  final Function onPressed;

  const RaiseSelfIconTextButton(
      this.iconData, this.iconText,
    {
      Key key,
      this.width = 60, this.height = 50.0, this.onPressed,
      this.iconSize = 30,
      this.iconColor = Colors.black,
    }
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedSelfButton(
      child: Column(
        children: <Widget>[
          Icon(iconData
            , size: iconSize
            ,color: iconColor,
          ),
          Text(iconText)
        ],
      ),
      width: width,
      height: height,
      onPressed: onPressed,
    );
  }
}

class RaisedSelfButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedSelfButton({
    Key key,
    @required this.child,
    this.gradient = const LinearGradient( colors: <Color>[Colors.grey, Colors.white, Colors.grey],),
    this.width = 60,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      //height: height,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        //gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
