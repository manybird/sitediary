import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'eform.dart';
import 'eform_item.dart';

part 'user.g.dart';


@JsonSerializable()
class User {
  User();

  UserSearchOption userSearchOption;

  @override
  String toString() {
    return '$loginName - $hashPassword ';
  }

  String fcmToken;

  @JsonKey(name: 'loginName')
  String loginName;
  String hashPassword;

  String company;

  String get fcmTopicName{
    return ((company??'') + '_' + (loginName??'')).toLowerCase();
  }

  String selectedEFormKey='';
  int userSelectedSection =-1;

  bool isLoginSuccess = false;
  bool isDoingLogin = false;
  bool get isNeedShowLoginScreen{
    if (isLoginSuccess) return false;
    if (isDoingLogin) return false;
    return true;
  }

  bool get hasLoginName{
    if (loginName==null) return false;
    if (loginName.isEmpty) return false;
    return true;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJsonString(String s){
    return User.fromJson(jsonDecode(s));
  }

  factory User.copy(User u){
    return User.fromJson( u.toJson());
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

}

@JsonSerializable()
class UserSearchOption {
  UserSearchOption();
  String searchText='';
  String sortingColumnItemKey ='';
  String sortingColumn ='';
  String sortingType='desc';

  void setSortingColumn(EFormItem v){
    sortingColumnItemKey =v.eFormItemKey;
    if (v.isDate){
      sortingColumn = 'itemValueDateTime';
    }else {
      sortingColumn = 'itemValue';
    }
  }

  void resetValues(){
    searchText='';
    sortingColumnItemKey ='';
    sortingColumn ='';
    sortingType='desc';
    itemSearchList = List<EFormItemSearch>();
  }

  factory UserSearchOption.fromJson(Map<String, dynamic> json) => _$UserSearchOptionFromJson(json);
  Map<String, dynamic> toJson() => _$UserSearchOptionToJson(this);

  List<EFormItemSearch> itemSearchList  = List<EFormItemSearch>();

  bool get  hasSearchData{
    if ((searchText??'').isNotEmpty){
      return true;
    }

    if (itemSearchList!=null){
      if(itemSearchList.length >0){
        if ((itemSearchList[0].eFormItemKey??'').isNotEmpty){
          return true;
        }
      }
    }

    return false;

  }

}

