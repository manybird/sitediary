// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eform_record_user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EFormRecordUserActivity _$EFormRecordUserActivityFromJson(
    Map<String, dynamic> json) {
  return EFormRecordUserActivity()
    ..autoID = json['autoID'] as int
    ..eFormRecordID = json['eFormRecordID'] as String
    ..eFormKey = json['eFormKey'] as String
    ..eFormItemKey = json['eFormItemKey'] as String
    ..loginName = json['loginName'] as String
    ..activityType = json['activityType'] as String
    ..activityDetail = json['activityDetail'] as String
    ..activityDate = json['activityDate'] == null
        ? null
        : DateTime.parse(json['activityDate'] as String)
    ..activityFrom = json['activityFrom'] as String
    ..activityIP = json['activityIP'] as String
    ..activityException = json['activityException'] as String
    ..actionLabel = json['actionLabel'] as String
    ..staffID = json['STAFF_ID'] as int
    ..userFullName = json['userFullName'] as String;
}

Map<String, dynamic> _$EFormRecordUserActivityToJson(
        EFormRecordUserActivity instance) =>
    <String, dynamic>{
      'autoID': instance.autoID,
      'eFormRecordID': instance.eFormRecordID,
      'eFormKey': instance.eFormKey,
      'eFormItemKey': instance.eFormItemKey,
      'loginName': instance.loginName,
      'activityType': instance.activityType,
      'activityDetail': instance.activityDetail,
      'activityDate': instance.activityDate?.toIso8601String(),
      'activityFrom': instance.activityFrom,
      'activityIP': instance.activityIP,
      'activityException': instance.activityException,
      'actionLabel': instance.actionLabel,
      'STAFF_ID': instance.staffID,
      'userFullName': instance.userFullName
    };
