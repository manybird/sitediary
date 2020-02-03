// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
      json['serverIP'] as String,
      json['isNeedLoadSettingFile'] as bool,
      json['isProcessingHttp'] as bool,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>))
    ..serverUrlPrefix = json['serverUrlPrefix'] as String
    ..serverUrlSub = json['serverUrlSub'] as String;
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'user': instance.user,
      'isNeedLoadSettingFile': instance.isNeedLoadSettingFile,
      'isProcessingHttp': instance.isProcessingHttp,
      'serverUrlPrefix': instance.serverUrlPrefix,
      'serverUrlSub': instance.serverUrlSub,
      'serverIP': instance.serverIP
    };
