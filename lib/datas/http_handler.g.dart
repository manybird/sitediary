// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_handler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHandlerBase _$RequestHandlerBaseFromJson(Map<String, dynamic> json) {
  return RequestHandlerBase()
    ..requestTypeInt = json['requestTypeInt'] as int
    ..requestType = json['requestType'] as int
    ..offset = json['offset'] as int
    ..offsetCount = json['offsetCount'] as int
    ..totalItem = json['totalItem'] as int
    ..eformList = (json['eformList'] as List)
        ?.map(
            (e) => e == null ? null : EForm.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..eformObject = json['eformObject'] == null
        ? null
        : EForm.fromJson(json['eformObject'] as Map<String, dynamic>)
    ..eformRecordObject = json['eformRecordObject'] == null
        ? null
        : EFormRecord.fromJson(
            json['eformRecordObject'] as Map<String, dynamic>)
    ..eformRecordDetailObject = json['eformRecordDetailObject'] == null
        ? null
        : EFormRecordDetail.fromJson(
            json['eformRecordDetailObject'] as Map<String, dynamic>)
    ..isValidRequest = json['isValidRequest'] as bool
    ..isSuccess = json['isSuccess'] as bool
    ..isOk = json['isOk'] as bool
    ..loginUser = json['loginUser'] == null
        ? null
        : User.fromJson(json['loginUser'] as Map<String, dynamic>)
    ..ex = json['ex'] as Map<String, dynamic>
    ..message = json['message'] as String;
}

Map<String, dynamic> _$RequestHandlerBaseToJson(RequestHandlerBase instance) =>
    <String, dynamic>{
      'requestTypeInt': instance.requestTypeInt,
      'requestType': instance.requestType,
      'offset': instance.offset,
      'offsetCount': instance.offsetCount,
      'totalItem': instance.totalItem,
      'eformList': instance.eformList,
      'eformObject': instance.eformObject,
      'eformRecordObject': instance.eformRecordObject,
      'eformRecordDetailObject': instance.eformRecordDetailObject,
      'isValidRequest': instance.isValidRequest,
      'isSuccess': instance.isSuccess,
      'isOk': instance.isOk,
      'loginUser': instance.loginUser,
      'ex': instance.ex,
      'message': instance.message
    };

RequestHandler _$RequestHandlerFromJson(Map<String, dynamic> json) {
  return RequestHandler()
    ..requestTypeInt = json['requestTypeInt'] as int
    ..requestType = json['requestType'] as int
    ..offset = json['offset'] as int
    ..offsetCount = json['offsetCount'] as int
    ..totalItem = json['totalItem'] as int
    ..eformList = (json['eformList'] as List)
        ?.map(
            (e) => e == null ? null : EForm.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..eformObject = json['eformObject'] == null
        ? null
        : EForm.fromJson(json['eformObject'] as Map<String, dynamic>)
    ..eformRecordObject = json['eformRecordObject'] == null
        ? null
        : EFormRecord.fromJson(
            json['eformRecordObject'] as Map<String, dynamic>)
    ..eformRecordDetailObject = json['eformRecordDetailObject'] == null
        ? null
        : EFormRecordDetail.fromJson(
            json['eformRecordDetailObject'] as Map<String, dynamic>)
    ..isValidRequest = json['isValidRequest'] as bool
    ..isSuccess = json['isSuccess'] as bool
    ..isOk = json['isOk'] as bool
    ..loginUser = json['loginUser'] == null
        ? null
        : User.fromJson(json['loginUser'] as Map<String, dynamic>)
    ..ex = json['ex'] as Map<String, dynamic>
    ..message = json['message'] as String
    ..requestBy = json['requestBy'] as String
    ..tokenString = json['tokenString'] as String
    ..jsonRequestString = json['jsonRequestString'] as String
    ..issuer = json['issuer'] as String;
}

Map<String, dynamic> _$RequestHandlerToJson(RequestHandler instance) =>
    <String, dynamic>{
      'requestTypeInt': instance.requestTypeInt,
      'requestType': instance.requestType,
      'offset': instance.offset,
      'offsetCount': instance.offsetCount,
      'totalItem': instance.totalItem,
      'eformList': instance.eformList,
      'eformObject': instance.eformObject,
      'eformRecordObject': instance.eformRecordObject,
      'eformRecordDetailObject': instance.eformRecordDetailObject,
      'isValidRequest': instance.isValidRequest,
      'isSuccess': instance.isSuccess,
      'isOk': instance.isOk,
      'loginUser': instance.loginUser,
      'ex': instance.ex,
      'message': instance.message,
      'requestBy': instance.requestBy,
      'tokenString': instance.tokenString,
      'jsonRequestString': instance.jsonRequestString,
      'issuer': instance.issuer
    };

ResponseItem _$ResponseItemFromJson(Map<String, dynamic> json) {
  return ResponseItem()
    ..requestTypeInt = json['requestTypeInt'] as int
    ..requestType = json['requestType'] as int
    ..offset = json['offset'] as int
    ..offsetCount = json['offsetCount'] as int
    ..totalItem = json['totalItem'] as int
    ..eformList = (json['eformList'] as List)
        ?.map(
            (e) => e == null ? null : EForm.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..eformObject = json['eformObject'] == null
        ? null
        : EForm.fromJson(json['eformObject'] as Map<String, dynamic>)
    ..eformRecordObject = json['eformRecordObject'] == null
        ? null
        : EFormRecord.fromJson(
            json['eformRecordObject'] as Map<String, dynamic>)
    ..eformRecordDetailObject = json['eformRecordDetailObject'] == null
        ? null
        : EFormRecordDetail.fromJson(
            json['eformRecordDetailObject'] as Map<String, dynamic>)
    ..isValidRequest = json['isValidRequest'] as bool
    ..isSuccess = json['isSuccess'] as bool
    ..isOk = json['isOk'] as bool
    ..loginUser = json['loginUser'] == null
        ? null
        : User.fromJson(json['loginUser'] as Map<String, dynamic>)
    ..ex = json['ex'] as Map<String, dynamic>
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ResponseItemToJson(ResponseItem instance) =>
    <String, dynamic>{
      'requestTypeInt': instance.requestTypeInt,
      'requestType': instance.requestType,
      'offset': instance.offset,
      'offsetCount': instance.offsetCount,
      'totalItem': instance.totalItem,
      'eformList': instance.eformList,
      'eformObject': instance.eformObject,
      'eformRecordObject': instance.eformRecordObject,
      'eformRecordDetailObject': instance.eformRecordDetailObject,
      'isValidRequest': instance.isValidRequest,
      'isSuccess': instance.isSuccess,
      'isOk': instance.isOk,
      'loginUser': instance.loginUser,
      'ex': instance.ex,
      'message': instance.message
    };
