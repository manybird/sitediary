import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'eform_record_user_activity.g.dart';

@JsonSerializable()
class EFormRecordUserActivity {
  EFormRecordUserActivity();
  int autoID ;
  String eFormRecordID ;
  String eFormKey ;
  String eFormItemKey ;
  String loginName ;

  String activityType ;
  String activityDetail ;
  DateTime activityDate ;
  String activityFrom ;
  String activityIP ;
  String activityException ;

  String actionLabel;

  String get activityDateString{
    return activityDate==null?'':DateFormat('yyyy-MM-dd kk:mm').format(activityDate);
  }

  @JsonKey(name: 'STAFF_ID')
  int staffID ;
  String userFullName ;

  factory EFormRecordUserActivity.fromJson(Map<String, dynamic> json) => _$EFormRecordUserActivityFromJson(json);

  factory EFormRecordUserActivity.fromJsonString(String s){
    return EFormRecordUserActivity.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$EFormRecordUserActivityToJson(this);
}