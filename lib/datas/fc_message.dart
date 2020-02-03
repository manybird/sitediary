import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'fc_message.g.dart';

@JsonSerializable()
class FcMessage{
  FcNotification notification;
  Object data;
  FcMessage();

  factory FcMessage.fromHashMap(Map<dynamic, dynamic> map){
   final m = FcMessage();
   m.notification = FcNotification();
   map.forEach((k,v){
     try {
       if (k=='notification'){

         m.notification.title = v['title'];
         m.notification.body = v['body'];
       }else if (k=='data'){
         m.data = v;
       }
     }catch (e){
        print('Error FcMessage.fromHashMap $e');
     }
   });

   return m;
  }

  factory FcMessage.fromJsonString(String s) =>
      FcMessage.fromJson(json.decode(s));

  factory FcMessage.fromJson(Map<String, dynamic> json) =>
      _$FcMessageFromJson(json);
  Map<String, dynamic> toJson() => _$FcMessageToJson(this);
  @override
  String toString() {
    return '$notification , data: $data';
  }


}

@JsonSerializable()
class FcNotification{
  String title;
  String body;
  FcNotification();
  factory FcNotification.fromJson(Map<String, dynamic> json) =>
      _$FcNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$FcNotificationToJson(this);
  @override
  String toString() {
    return 'title: $title , body: $body';
  }


}