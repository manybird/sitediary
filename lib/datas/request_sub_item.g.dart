// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_sub_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestSubItem _$RequestSubItemFromJson(Map<String, dynamic> json) {
  return RequestSubItem()
    ..userSearchOption = json['userSearchOption'] == null
        ? null
        : UserSearchOption.fromJson(
            json['userSearchOption'] as Map<String, dynamic>)
    ..loginName = json['loginName'] as String
    ..hashPassword = json['hashPassword'] as String
    ..company = json['company'] as String
    ..selectedEFormKey = json['selectedEFormKey'] as String
    ..userSelectedSection = json['userSelectedSection'] as int
    ..isLoginSuccess = json['isLoginSuccess'] as bool
    ..isDoingLogin = json['isDoingLogin'] as bool
    ..fcmToken = json['fcmToken'] as String
    ..eFormKey = json['eFormKey'] as String
    ..eFormRecordID = json['eFormRecordID'] as String
    ..skip = json['skip'] as int
    ..topN = json['topN'] as int
    ..action = json['action'] == null
        ? null
        : EFormItemSectionAction.fromJson(
            json['action'] as Map<String, dynamic>)
    ..currentSection = json['currentSection'] == null
        ? null
        : EFormItemSection.fromJson(
            json['currentSection'] as Map<String, dynamic>)
    ..currentRecordDetail = json['currentRecordDetail'] == null
        ? null
        : EFormRecordDetail.fromJson(
            json['currentRecordDetail'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RequestSubItemToJson(RequestSubItem instance) =>
    <String, dynamic>{
      'userSearchOption': instance.userSearchOption,
      'loginName': instance.loginName,
      'hashPassword': instance.hashPassword,
      'company': instance.company,
      'selectedEFormKey': instance.selectedEFormKey,
      'userSelectedSection': instance.userSelectedSection,
      'isLoginSuccess': instance.isLoginSuccess,
      'isDoingLogin': instance.isDoingLogin,
      'fcmToken': instance.fcmToken,
      'eFormKey': instance.eFormKey,
      'eFormRecordID': instance.eFormRecordID,
      'skip': instance.skip,
      'topN': instance.topN,
      'action': instance.action,
      'currentSection': instance.currentSection,
      'currentRecordDetail': instance.currentRecordDetail
    };
