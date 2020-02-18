import 'package:flutter/material.dart';


class SiteDiaryTabBar extends StatelessWidget {

  final String title;

  SiteDiaryTabBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child:Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50],
        ),
        child: Text(title,
            style: TextStyle(color: Colors.black54,fontSize: 18)),
      ),
    );
  }
}
