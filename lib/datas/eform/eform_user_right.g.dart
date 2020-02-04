// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eform_user_right.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EFormUserRight _$EFormUserRightFromJson(Map<String, dynamic> json) {
  return EFormUserRight()
    ..eFormKey = json['eFormKey'] as String
    ..eFormItemKey = json['eFormItemKey'] as String
    ..section = json['section'] as int
    ..orderSeq = json['orderSeq'] as int
    ..userRight = json['userRight'] as String
    ..userRightOption1 = json['userRightOption1'] as String
    ..userRightOption2 = json['userRightOption2'] as String
    ..loginName = json['loginName'] as String
    ..postShortName = json['post_short_name'] as String
    ..staffID = json['STAFF_ID'] as int;
}

Map<String, dynamic> _$EFormUserRightToJson(EFormUserRight instance) =>
    <String, dynamic>{
      'eFormKey': instance.eFormKey,
      'eFormItemKey': instance.eFormItemKey,
      'section': instance.section,
      'orderSeq': instance.orderSeq,
      'userRight': instance.userRight,
      'userRightOption1': instance.userRightOption1,
      'userRightOption2': instance.userRightOption2,
      'loginName': instance.loginName,
      'post_short_name': instance.postShortName,
      'STAFF_ID': instance.staffID
    };
