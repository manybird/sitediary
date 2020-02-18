// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_handler_sitediary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHandlerSiteDiary _$RequestHandlerSiteDiaryFromJson(
    Map<String, dynamic> json) {
  return RequestHandlerSiteDiary(json['loginUser'] == null
      ? null
      : User.fromJson(json['loginUser'] as Map<String, dynamic>))
    ..requestTypeInt = json['requestTypeInt'] as int
    ..requestType = json['requestType'] as int
    ..pageIndex = json['pageIndex'] as int
    ..pageSize = json['pageSize'] as int
    ..totalItem = json['totalItem'] as int
    ..isValidRequest = json['isValidRequest'] as bool
    ..isSuccess = json['isSuccess'] as bool
    ..isOk = json['isOk'] as bool
    ..siteDiaryWorker = json['siteDiaryWorker'] == null
        ? null
        : SiteDiaryWorker.fromJson(
            json['siteDiaryWorker'] as Map<String, dynamic>)
    ..ex = json['ex'] as Map<String, dynamic>
    ..message = json['message'] as String;
}

Map<String, dynamic> _$RequestHandlerSiteDiaryToJson(
        RequestHandlerSiteDiary instance) =>
    <String, dynamic>{
      'requestTypeInt': instance.requestTypeInt,
      'requestType': instance.requestType,
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalItem': instance.totalItem,
      'isValidRequest': instance.isValidRequest,
      'isSuccess': instance.isSuccess,
      'isOk': instance.isOk,
      'loginUser': instance.loginUser,
      'siteDiaryWorker': instance.siteDiaryWorker,
      'ex': instance.ex,
      'message': instance.message
    };
