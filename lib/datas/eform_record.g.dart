// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eform_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EFormRecord _$EFormRecordFromJson(Map<String, dynamic> json) {
  return EFormRecord()
    ..eFormKey = json['eFormKey'] as String
    ..eFormRecordID = json['eFormRecordID'] as String
    ..eFormItemCurrentSection = json['eFormItemCurrentSection'] as int
    ..recordStatusLabel = json['recordStatusLabel'] as String
    ..createDate = json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String)
    ..createBy = json['createBy'] as String
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String)
    ..modifyBy = json['modifyBy'] as String
    ..tempDescription = json['tempDescription'] as String
    ..fromLoginName = json['fromLoginName'] as String
    ..toLoginName = json['toLoginName'] as String
    ..currentSectionRight = json['currentSectionRight'] == null
        ? null
        : EFormUserRight.fromJson(
            json['currentSectionRight'] as Map<String, dynamic>)
    ..actionListPrivate = (json['actionListPrivate'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemSectionAction.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..itemDetailList = (json['itemDetailList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormRecordDetail.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..activityList = (json['activityList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormRecordUserActivity.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..sectionList = (json['sectionList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemSection.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EFormRecordToJson(EFormRecord instance) =>
    <String, dynamic>{
      'eFormKey': instance.eFormKey,
      'eFormRecordID': instance.eFormRecordID,
      'eFormItemCurrentSection': instance.eFormItemCurrentSection,
      'recordStatusLabel': instance.recordStatusLabel,
      'createDate': instance.createDate?.toIso8601String(),
      'createBy': instance.createBy,
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'modifyBy': instance.modifyBy,
      'tempDescription': instance.tempDescription,
      'fromLoginName': instance.fromLoginName,
      'toLoginName': instance.toLoginName,
      'currentSectionRight': instance.currentSectionRight,
      'actionListPrivate': instance.actionListPrivate,
      'itemDetailList': instance.itemDetailList,
      'activityList': instance.activityList,
      'sectionList': instance.sectionList
    };

EFormRecordDetail _$EFormRecordDetailFromJson(Map<String, dynamic> json) {
  return EFormRecordDetail()
    ..eFormKey = json['eFormKey'] as String
    ..eFormItemKey = json['eFormItemKey'] as String
    ..orderSeq = json['orderSeq'] as int
    ..itemType = json['itemType'] as String
    ..itemLabel = json['itemLabel'] as String
    ..itemSubLabel = json['itemSubLabel'] as String
    ..defaultValue = json['defaultValue'] as String
    ..valuesOptions = json['valuesOptions'] as String
    ..valuesOptionObject = json['valuesOptionObject'] == null
        ? null
        : EFormItemValuesOption.fromJson(
            json['valuesOptionObject'] as Map<String, dynamic>)
    ..isRequired = json['isRequired'] as int
    ..requiredMsg = json['requiredMsg'] as String
    ..superItemKey = json['superItemKey'] as String
    ..autoValueFormat = json['autoValueFormat'] as String
    ..isShowOnSearch = json['isShowOnSearch'] as bool
    ..isShowOnList = json['isShowOnList'] as bool
    ..isAbleToSearch = json['isAbleToSearch'] as bool
    ..isAbleToSort = json['isAbleToSort'] as bool
    ..dataFormat = json['dataFormat'] as String
    ..itemOption1 = json['itemOption1'] as String
    ..itemOption2 = json['itemOption2'] as String
    ..isReadOnly = json['isReadOnly'] as bool
    ..eFormRecordID = json['eFormRecordID'] as String
    ..itemValue = json['itemValue'] as String
    ..itemValueDecimal = (json['itemValueDecimal'] as num)?.toDouble()
    ..itemValueDateTime = json['itemValueDateTime'] == null
        ? null
        : DateTime.parse(json['itemValueDateTime'] as String)
    ..itemPath = json['itemPath'] as String
    ..itemThumbPath = json['itemThumbPath'] as String
    ..itemPathServer = json['itemPathServer'] as String
    ..createDate = json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String)
    ..createBy = json['createBy'] as String
    ..modifyDate = json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String)
    ..modifyBy = json['modifyBy'] as String;
}

Map<String, dynamic> _$EFormRecordDetailToJson(EFormRecordDetail instance) =>
    <String, dynamic>{
      'eFormKey': instance.eFormKey,
      'eFormItemKey': instance.eFormItemKey,
      'orderSeq': instance.orderSeq,
      'itemType': instance.itemType,
      'itemLabel': instance.itemLabel,
      'itemSubLabel': instance.itemSubLabel,
      'defaultValue': instance.defaultValue,
      'valuesOptions': instance.valuesOptions,
      'valuesOptionObject': instance.valuesOptionObject,
      'isRequired': instance.isRequired,
      'requiredMsg': instance.requiredMsg,
      'superItemKey': instance.superItemKey,
      'autoValueFormat': instance.autoValueFormat,
      'isShowOnSearch': instance.isShowOnSearch,
      'isShowOnList': instance.isShowOnList,
      'isAbleToSearch': instance.isAbleToSearch,
      'isAbleToSort': instance.isAbleToSort,
      'dataFormat': instance.dataFormat,
      'itemOption1': instance.itemOption1,
      'itemOption2': instance.itemOption2,
      'isReadOnly': instance.isReadOnly,
      'eFormRecordID': instance.eFormRecordID,
      'itemValue': instance.itemValue,
      'itemValueDecimal': instance.itemValueDecimal,
      'itemValueDateTime': instance.itemValueDateTime?.toIso8601String(),
      'itemPath': instance.itemPath,
      'itemThumbPath': instance.itemThumbPath,
      'itemPathServer': instance.itemPathServer,
      'createDate': instance.createDate?.toIso8601String(),
      'createBy': instance.createBy,
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'modifyBy': instance.modifyBy
    };
