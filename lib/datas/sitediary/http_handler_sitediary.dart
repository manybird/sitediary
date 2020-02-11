import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import '../user.dart';
import 'sitediary_worker.dart';
part 'http_handler_sitediary.g.dart';

@JsonSerializable()
class RequestHandlerSiteDiary{
  int requestTypeInt;
  int requestType;

  int offset =-1;
  int offsetCount=-1;

  int totalItem = 0;

  bool isValidRequest = false;
  bool isSuccess = false;
  bool isOk = false;

  User loginUser;
  SiteDiaryWorker siteDiaryWorker;

  //@JsonKey(ignore: true)
  Map<String,dynamic> ex;
  String message;

  RequestHandlerSiteDiary(this.loginUser);
  factory RequestHandlerSiteDiary.fromJson(Map<String, dynamic> json) =>
      _$RequestHandlerSiteDiaryFromJson(json);
  Map<String, dynamic> toJson() => _$RequestHandlerSiteDiaryToJson(this);

  String toJsonString() => json.encode(this.toJson());

  factory RequestHandlerSiteDiary.fromJsonString(String s) {
    return RequestHandlerSiteDiary.fromJson(jsonDecode(s));
  }

  @override
  String toString() {
    return toJsonString();
  }

}