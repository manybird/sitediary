// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EForm _$EFormFromJson(Map<String, dynamic> json) {
  return EForm()
    ..eFormKey = json['eFormKey'] as String
    ..subject = json['subject'] as String
    ..subSubject = json['subSubject'] as String
    ..orderSeq = json['orderSeq'] as int
    ..createDate = json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String)
    ..option1 = json['option1'] as String
    ..option2 = json['option2'] as String
    ..baseDir = json['baseDir'] as String
    ..eFormMode = json['eFormMode'] as String
    ..formDescription = json['formDescription'] as String
    ..initSection = json['initSection'] as int
    ..recordList = (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : EFormRecord.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..itemList = (json['itemList'] as List)
        ?.map((e) =>
            e == null ? null : EFormItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..itemListForSort = (json['itemListForSort'] as List)
        ?.map((e) =>
            e == null ? null : EFormItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..sectionList = (json['sectionList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemSection.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..formItemUserRightList = (json['formItemUserRightList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormUserRight.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..formUserRight = json['formUserRight'] == null
        ? null
        : EFormUserRight.fromJson(json['formUserRight'] as Map<String, dynamic>)
    ..itemSearchList = (json['itemSearchList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemSearch.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EFormToJson(EForm instance) => <String, dynamic>{
      'eFormKey': instance.eFormKey,
      'subject': instance.subject,
      'subSubject': instance.subSubject,
      'orderSeq': instance.orderSeq,
      'createDate': instance.createDate?.toIso8601String(),
      'option1': instance.option1,
      'option2': instance.option2,
      'baseDir': instance.baseDir,
      'eFormMode': instance.eFormMode,
      'formDescription': instance.formDescription,
      'initSection': instance.initSection,
      'recordList': instance.recordList,
      'itemList': instance.itemList,
      'itemListForSort': instance.itemListForSort,
      'sectionList': instance.sectionList,
      'formItemUserRightList': instance.formItemUserRightList,
      'formUserRight': instance.formUserRight,
      'itemSearchList': instance.itemSearchList
    };

EFormItemSearch _$EFormItemSearchFromJson(Map<String, dynamic> json) {
  return EFormItemSearch(
      orderSeq: json['orderSeq'] as int,
      isRangeSearch: json['isRangeSearch'] as bool)
    ..itemLabel = json['itemLabel'] as String
    ..eFormKey = json['eFormKey'] as String
    ..eFormItemKey = json['eFormItemKey'] as String
    ..option1 = json['option1'] as String
    ..option2 = json['option2'] as String
    ..itemType = json['itemType'] as String
    ..v1 = json['v1'] as String
    ..v2 = json['v2'] as String;
}

Map<String, dynamic> _$EFormItemSearchToJson(EFormItemSearch instance) =>
    <String, dynamic>{
      'itemLabel': instance.itemLabel,
      'eFormKey': instance.eFormKey,
      'eFormItemKey': instance.eFormItemKey,
      'orderSeq': instance.orderSeq,
      'isRangeSearch': instance.isRangeSearch,
      'option1': instance.option1,
      'option2': instance.option2,
      'itemType': instance.itemType,
      'v1': instance.v1,
      'v2': instance.v2
    };
