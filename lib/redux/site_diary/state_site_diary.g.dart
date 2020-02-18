// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_site_diary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteDiaryState _$SiteDiaryStateFromJson(Map<String, dynamic> json) {
  return SiteDiaryState(json['currentSiteDiaryWorker'] == null
      ? null
      : SiteDiaryWorker.fromJson(
          json['currentSiteDiaryWorker'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SiteDiaryStateToJson(SiteDiaryState instance) =>
    <String, dynamic>{
      'currentSiteDiaryWorker': instance.currentSiteDiaryWorker
    };
