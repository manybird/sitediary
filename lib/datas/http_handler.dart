import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'eform_record.dart';
import 'user.dart';
import 'eform.dart';
import 'request_sub_item.dart';

part 'http_handler.g.dart';

@JsonSerializable()
class RequestHandlerBase {
  RequestHandlerBase();
  int requestTypeInt;
  int requestType;

  int offset =-1;
  int offsetCount=-1;

  int totalItem = 0;

  List<EForm> eformList;
  EForm eformObject;
  EFormRecord eformRecordObject;
  EFormRecordDetail eformRecordDetailObject;

  bool isValidRequest = false;
  bool isSuccess = false;
  bool isOk = false;

  User loginUser;

  //@JsonKey(ignore: true)
  Map<String,dynamic> ex;
  String message;

  factory RequestHandlerBase.fromJson(Map<String, dynamic> json) =>
      _$RequestHandlerBaseFromJson(json);

  factory RequestHandlerBase.fromJsonString(String s) {
    return RequestHandlerBase.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$RequestHandlerBaseToJson(this);
}

@JsonSerializable()
class RequestHandler extends RequestHandlerBase {
  RequestHandler();
  String requestBy;
  String tokenString;
  String jsonRequestString;
  String issuer;



  factory RequestHandler.fromJson(Map<String, dynamic> json) =>
      _$RequestHandlerFromJson(json);

  factory RequestHandler.fromJsonString(String s) {
    return RequestHandler.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$RequestHandlerToJson(this);

  String toJsonString() => json.encode(this.toJson());


  @override
  String toString() {
    return toJsonString();
  }

  factory RequestHandler.fromSubItem(RequestSubItem sub, int requestTypeInt){
    return RequestHandler()
      ..requestBy = sub.loginName
      ..issuer = sub.loginName
      ..jsonRequestString = json.encode(sub)
      ..requestTypeInt = requestTypeInt;
  }

  factory RequestHandler.fromUser(User u, int requestTypeInt){
    return RequestHandler()
      ..requestBy = u.loginName
      ..issuer = u.loginName
      ..jsonRequestString = json.encode(u)
      ..requestTypeInt = requestTypeInt;
  }

  factory RequestHandler.fromListItemRequest(User u, int requestTypeInt,int offset, int offsetCount){
    return RequestHandler.fromUser(u,requestTypeInt)
      ..offset = offset
      ..offsetCount = offsetCount;
  }
}

@JsonSerializable()
class ResponseItem extends RequestHandlerBase  {
  ResponseItem();

  factory ResponseItem.fromJson(Map<String, dynamic> json) =>
      _$ResponseItemFromJson(json);

  factory ResponseItem.fromJsonString(String s) {
    return ResponseItem.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$ResponseItemToJson(this);
}

