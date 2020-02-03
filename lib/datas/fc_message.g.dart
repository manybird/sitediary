// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fc_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcMessage _$FcMessageFromJson(Map<String, dynamic> json) {
  return FcMessage()
    ..notification = json['notification'] == null
        ? null
        : FcNotification.fromJson(json['notification'] as Map<String, dynamic>)
    ..data = json['data'];
}

Map<String, dynamic> _$FcMessageToJson(FcMessage instance) => <String, dynamic>{
      'notification': instance.notification,
      'data': instance.data
    };

FcNotification _$FcNotificationFromJson(Map<String, dynamic> json) {
  return FcNotification()
    ..title = json['title'] as String
    ..body = json['body'] as String;
}

Map<String, dynamic> _$FcNotificationToJson(FcNotification instance) =>
    <String, dynamic>{'title': instance.title, 'body': instance.body};
