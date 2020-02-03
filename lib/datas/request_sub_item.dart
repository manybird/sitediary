import 'package:json_annotation/json_annotation.dart';
import 'eform_item_section.dart';
import 'eform_record.dart';
import 'user.dart';
import 'dart:convert';

part 'request_sub_item.g.dart';

@JsonSerializable()
class RequestSubItem extends User {
  RequestSubItem();

  String fcmToken;
  String eFormKey;
  String eFormRecordID;
  //String hashPassword;
  int skip =-1;
  int topN =-1;

  EFormItemSectionAction action;
  EFormItemSection currentSection;
  EFormRecordDetail currentRecordDetail;

  factory RequestSubItem.fromJson(Map<String, dynamic> json) {

    return  _$RequestSubItemFromJson(json)
      ..topN=-1
      ..skip=-1
      ..userSelectedSection= -1
    ;

  }

  factory RequestSubItem.fromJsonString(String s){
    return RequestSubItem.fromJson(jsonDecode(s))
      ..skip=-1
      ..topN=-1;
  }

  factory RequestSubItem.fromUser(User u){
    final js = u.toJson();
    js['userSearchOption'] = null;
    return RequestSubItem.fromJson(js)
    ..skip=-1
    ..topN=-1
    ..userSearchOption = u.userSearchOption;
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated helper method `_$RequestSubItemToJson`.
  Map<String, dynamic> toJson() => _$RequestSubItemToJson(this);

}
