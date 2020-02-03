import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'eform_user_right.g.dart';

@JsonSerializable()
class EFormUserRight {
  EFormUserRight();
  String eFormKey;
  String eFormItemKey;
  int section;
  int orderSeq;
  String userRight;
  String userRightOption1;
  String userRightOption2;
  String loginName;
  @JsonKey(name: 'post_short_name')
  String postShortName;
  @JsonKey(name: 'STAFF_ID')
  int staffID;

  get objectKey {
    return "${this.eFormKey}___${this.eFormItemKey}";
  }

  bool get canRead {
    return canCheck("R");
  }

  bool get canWrite {
    return canCheck("W");
  }

  bool get  canCreate {
    return canCheck("C");
  }

  bool get  canReport {
    return canCheck("P");
  }

  bool get  canX {
    return canCheck("X");
  }

  bool canCheck(String mode) {
    if (userRight == null) return false;
    userRight = userRight.toUpperCase();
    //if (userRight.contains("X")) return false;
    if (userRight.contains(mode)) return true;
    if (userRight.contains("F")) return true;
    return false;
  }

  factory EFormUserRight.fromJson(Map<String, dynamic> json) =>
      _$EFormUserRightFromJson(json);

  factory EFormUserRight.fromJsonString(String s) {
    return EFormUserRight.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$EFormUserRightToJson(this);
}
