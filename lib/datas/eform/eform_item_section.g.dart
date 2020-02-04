// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eform_item_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EFormItemSection _$EFormItemSectionFromJson(Map<String, dynamic> json) {
  return EFormItemSection()
    ..eFormKey = json['eFormKey'] as String
    ..section = json['section'] as int
    ..mainSection = json['mainSection'] as int
    ..sectionNext = json['sectionNext'] as int
    ..sectionLabel = json['sectionLabel'] as String
    ..recordStatusLabel = json['recordStatusLabel'] as String
    ..isPrivateSection = json['isPrivateSection'] as bool
    ..isAssignSection = json['isAssignSection'] as bool
    ..assignSectionFormItemKey = json['assignSectionFormItemKey'] as String
    ..isReplySection = json['isReplySection'] as bool
    ..detailList = (json['detailList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemSectionDetail.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..actionList = (json['actionList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemSectionAction.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..formSectionRight = json['formSectionRight'] == null
        ? null
        : EFormUserRight.fromJson(
            json['formSectionRight'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EFormItemSectionToJson(EFormItemSection instance) =>
    <String, dynamic>{
      'eFormKey': instance.eFormKey,
      'section': instance.section,
      'mainSection': instance.mainSection,
      'sectionNext': instance.sectionNext,
      'sectionLabel': instance.sectionLabel,
      'recordStatusLabel': instance.recordStatusLabel,
      'isPrivateSection': instance.isPrivateSection,
      'isAssignSection': instance.isAssignSection,
      'assignSectionFormItemKey': instance.assignSectionFormItemKey,
      'isReplySection': instance.isReplySection,
      'detailList': instance.detailList,
      'actionList': instance.actionList,
      'formSectionRight': instance.formSectionRight
    };

EFormItemSectionDetail _$EFormItemSectionDetailFromJson(
    Map<String, dynamic> json) {
  return EFormItemSectionDetail()
    ..eFormKey = json['eFormKey'] as String
    ..section = json['section'] as int
    ..eFormItemKey = json['eFormItemKey'] as String
    ..recordDetail = json['recordDetail'] == null
        ? null
        : EFormRecordDetail.fromJson(
            json['recordDetail'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EFormItemSectionDetailToJson(
        EFormItemSectionDetail instance) =>
    <String, dynamic>{
      'eFormKey': instance.eFormKey,
      'section': instance.section,
      'eFormItemKey': instance.eFormItemKey,
      'recordDetail': instance.recordDetail
    };

EFormItemSectionAction _$EFormItemSectionActionFromJson(
    Map<String, dynamic> json) {
  return EFormItemSectionAction(
      section: json['section'] as int,
      action: json['action'] as int,
      actionTargetSection: json['actionTargetSection'] as int)
    ..eFormKey = json['eFormKey'] as String
    ..actionLabel = json['actionLabel'] as String
    ..actionType = json['actionType'] as int;
}

Map<String, dynamic> _$EFormItemSectionActionToJson(
        EFormItemSectionAction instance) =>
    <String, dynamic>{
      'eFormKey': instance.eFormKey,
      'section': instance.section,
      'action': instance.action,
      'actionTargetSection': instance.actionTargetSection,
      'actionLabel': instance.actionLabel,
      'actionType': instance.actionType
    };
