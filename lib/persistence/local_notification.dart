

import 'package:sitediary/datas/fc_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_permissions/notification_permissions.dart';

class LocalNotification{

  String resultPayload;

  LocalNotification() ;

  Future<bool> showDialogEnableNotification(BuildContext context) {
    return showDialog(context: context, builder: (c) {
      return  AlertDialog(content:  Text("Application require notification, enable it in setting?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(c).pop(false),
            child:  Text("NO"),
          ),
          FlatButton(onPressed: () {
            return Navigator.of(c).pop(true);
          },
            child:  Text("YES"),
          ),
        ],);
    });
  }

  void requestNotificationPermissionsIfNeed (BuildContext context) async {
    var pm = NotificationPermissions();
    PermissionStatus value = await pm.getNotificationPermissionStatus();

    if (value != PermissionStatus.granted) {
      this.showDialogEnableNotification(context).then((isShow){
       if (isShow) pm.requestNotificationPermissions();
      });
    }
  }

  void createNotification (FcNotification m) async {

    final plugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    final androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosSetting = IOSInitializationSettings(
        onDidReceiveLocalNotification: (i, s, s2, s3) async {
          return Future.value();
        });
    final initializationSettings = InitializationSettings(
        androidSetting, iosSetting);

    plugin.initialize(
        initializationSettings, onSelectNotification: (String payload) async {
      resultPayload = payload;
      //await Navigator.push(context, MaterialPageRoute( builder: (context) => new SecondScreen(payload)),);
    });


    var adSpecifics = AndroidNotificationDetails(
        'ChannelPSL', 'PSL Channel', ' PSL Channel for eForm',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

    var spe = NotificationDetails(adSpecifics, IOSNotificationDetails());
    await plugin.show(
        0, m.title, m.body, spe, payload: 'item x');
  }


}