import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'eform_record.dart';
import 'eform_user_right.dart';
import 'eform_item.dart';
import 'eform_item_section.dart';

part 'eform.g.dart';

@JsonSerializable()
class EForm {
  EForm();

  String eFormKey;
  String subject;
  String subSubject;
  int orderSeq;
  DateTime createDate;
  String option1;
  String option2;
  String baseDir;
  String eFormMode;
  String formDescription;
  int initSection;

  List<EFormRecord> recordList;
  List<EFormItem> itemList;
  List<EFormItem> itemListForSort;
  List< EFormItemSection> sectionList;

  List<EFormUserRight> formItemUserRightList;
  EFormUserRight formUserRight;

  List<EFormItem> get sortableItemList{

    if (itemListForSort==null) {
      itemListForSort =List<EFormItem>()..add(EFormItem.empty());

      if (itemList !=null) {
        itemListForSort.addAll(itemList);
      }
    }
    return itemListForSort;
  }

  EFormItem getEFormItemByItemKey(String key){
    if (itemList==null) return EFormItem.empty();
    for (final item in itemListForSort){
      if (item.eFormItemKey == key) return item;
    }
    return EFormItem.empty();
  }

  factory EForm.fromJson(Map<String, dynamic> json) => _$EFormFromJson(json);

  factory EForm.fromJsonString(String string) {
    return EForm.fromJson(jsonDecode(string));
  }

  Map<String, dynamic> toJson() => _$EFormToJson(this);

  static List<EForm> fromJsonList(List jsonList) {
    final l = jsonList.map<EForm>((obj) => EForm.fromJson(obj));
    return l.toList();
  }

  List<EFormItemSearch> itemSearchList ;
}

@JsonSerializable()
class EFormItemSearch {
  EFormItemSearch({this.orderSeq=0,this.isRangeSearch=false});
  String itemLabel = '';
  String eFormKey ='';
  String eFormItemKey ='';
  int orderSeq =0;
  bool isRangeSearch =false;
  String option1 ='';
  String option2 ='';

  String itemType ='';
  String v1 ='';
  String v2 ='';

  bool get isDate{
    if (itemType==null) return false;

    return itemType.startsWith('DateTime');
  }

  int get hashCode => eFormItemKey.hashCode;
  bool operator==(Object other) => other is EFormItemSearch && other.eFormItemKey == eFormItemKey;

  factory EFormItemSearch.empty(){
    return EFormItemSearch();
  }

  DateTime v1AsDateTime (){
    return this.getStringAsDate(this.v1);
  }

  DateTime v2AsDateTime (){
    return this.getStringAsDate(this.v2);
  }

  setValue(DateTime dateTime, bool isFirstValue){
    String v = '';
    if (dateTime!=null)
      v = dateTime.toIso8601String().substring(0,10);

    if (isFirstValue) {
      v1 = v;
      if (isRangeSearch){
          if (v1.compareTo(v2) >0) v2 = v1;
      }
    }
    else {
      v2 = v;
      if (isRangeSearch){
        if (v1.compareTo(v2) >0) v1 = v2;
      }
    }

  }

  String getValueForDateAsString (bool isFirstValue){
    DateTime dt = this.getValue(isFirstValue);
    return dt.toIso8601String().substring(0,10);
  }

  DateTime getValue (bool isFirstValue){
    if (isFirstValue)
      return this.getStringAsDate(this.v1);
    else
      return this.getStringAsDate(this.v2);
  }

  DateTime getStringAsDate (String s) {
    DateTime now = DateTime.now();
    DateTime sd = new DateTime(now.year, now.month, now.day);
    if (s == null) return sd;
    if (s.isEmpty) return sd;

    List<String> dp = s.split('-');

    if (dp.length != 3) return sd;

    int y = int.tryParse(dp[0]);
    int m = int.tryParse(dp[1]);
    int d = int.tryParse(dp[2]);

    return DateTime(y, m, d);
  }

  factory EFormItemSearch.fromJson(Map<String, dynamic> json) => _$EFormItemSearchFromJson(json);

  Map<String, dynamic> toJson() => _$EFormItemSearchToJson(this);
}
