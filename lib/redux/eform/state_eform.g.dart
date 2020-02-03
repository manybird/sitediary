// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_eform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EFormState _$EFormStateFromJson(Map<String, dynamic> json) {
  return EFormState(json['currentEForm'] == null
      ? null
      : EForm.fromJson(json['currentEForm'] as Map<String, dynamic>));
}

Map<String, dynamic> _$EFormStateToJson(EFormState instance) =>
    <String, dynamic>{'currentEForm': instance.currentEForm};
