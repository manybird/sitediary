// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userSearchOption = json['userSearchOption'] == null
        ? null
        : UserSearchOption.fromJson(
            json['userSearchOption'] as Map<String, dynamic>)
    ..fcmToken = json['fcmToken'] as String
    ..loginName = json['loginName'] as String
    ..hashPassword = json['hashPassword'] as String
    ..company = json['company'] as String
    ..selectedEFormKey = json['selectedEFormKey'] as String
    ..userSelectedSection = json['userSelectedSection'] as int
    ..isLoginSuccess = json['isLoginSuccess'] as bool
    ..isDoingLogin = json['isDoingLogin'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userSearchOption': instance.userSearchOption,
      'fcmToken': instance.fcmToken,
      'loginName': instance.loginName,
      'hashPassword': instance.hashPassword,
      'company': instance.company,
      'selectedEFormKey': instance.selectedEFormKey,
      'userSelectedSection': instance.userSelectedSection,
      'isLoginSuccess': instance.isLoginSuccess,
      'isDoingLogin': instance.isDoingLogin
    };

UserSearchOption _$UserSearchOptionFromJson(Map<String, dynamic> json) {
  return UserSearchOption()
    ..searchText = json['searchText'] as String
    ..sortingColumnItemKey = json['sortingColumnItemKey'] as String
    ..sortingColumn = json['sortingColumn'] as String
    ..sortingType = json['sortingType'] as String
    ..itemSearchList = (json['itemSearchList'] as List)
        ?.map((e) => e == null
            ? null
            : EFormItemSearch.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserSearchOptionToJson(UserSearchOption instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'sortingColumnItemKey': instance.sortingColumnItemKey,
      'sortingColumn': instance.sortingColumn,
      'sortingType': instance.sortingType,
      'itemSearchList': instance.itemSearchList
    };
