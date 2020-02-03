// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_eform_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EFormRecordState _$EFormRecordStateFromJson(Map<String, dynamic> json) {
  return EFormRecordState(json['currentEFormRecord'] == null
      ? null
      : EFormRecord.fromJson(
          json['currentEFormRecord'] as Map<String, dynamic>));
}

Map<String, dynamic> _$EFormRecordStateToJson(EFormRecordState instance) =>
    <String, dynamic>{'currentEFormRecord': instance.currentEFormRecord};
