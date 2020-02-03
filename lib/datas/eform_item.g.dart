// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eform_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EFormItem _$EFormItemFromJson(Map<String, dynamic> json) {
  return EFormItem()
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
    ..isReadOnly = json['isReadOnly'] as bool;
}

Map<String, dynamic> _$EFormItemToJson(EFormItem instance) => <String, dynamic>{
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
      'isReadOnly': instance.isReadOnly
    };

EFormItemValuesOptionItem _$EFormItemValuesOptionItemFromJson(
    Map<String, dynamic> json) {
  return EFormItemValuesOptionItem()
    ..v = json['v'] as String
    ..t = json['t'] as String;
}

Map<String, dynamic> _$EFormItemValuesOptionItemToJson(
        EFormItemValuesOptionItem instance) =>
    <String, dynamic>{'v': instance.v, 't': instance.t};

EFormItemValuesOption _$EFormItemValuesOptionFromJson(
    Map<String, dynamic> json) {
  return EFormItemValuesOption()
    ..isSingle = json['isSingle'] as bool
    ..list = (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemValuesOptionItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EFormItemValuesOptionToJson(
        EFormItemValuesOption instance) =>
    <String, dynamic>{'isSingle': instance.isSingle, 'list': instance.list};
