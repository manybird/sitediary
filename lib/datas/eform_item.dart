import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';


part 'eform_item.g.dart';



@JsonSerializable()
class EFormItem {
  EFormItem();
  String eFormKey;
  String eFormItemKey;

  int orderSeq;
  String itemType;
  String itemLabel;
  String itemSubLabel;
  String defaultValue;
  String valuesOptions;
  EFormItemValuesOption valuesOptionObject;

  int isRequired;
  String requiredMsg;

  String superItemKey;
  String autoValueFormat;
  bool isShowOnSearch;
  bool isShowOnList;

  bool isAbleToSearch;
  bool isAbleToSort;

  String dataFormat;
  String itemOption1;
  String itemOption2;
  bool isReadOnly;

  bool get isDateTimeNowIfEmpty{
    return itemType==null?false: itemType =='DateTimeNowIfEmpty';
  }

  bool get isDate{
    return itemType==null?false:itemType.startsWith('DateTime');
  }

  bool get isCombo{
    return itemType==null?false:itemType.startsWith('Combo');
  }

  bool get isComboEdit{
    return itemType==null?false:itemType.startsWith('ComboEdit');
  }

  bool get isCheckBox{
    return itemType==null?false:itemType.startsWith('CheckBox');
  }

  bool get isFile{
    return itemType==null?false:itemType.startsWith('File');
  }

  bool get isSignature{
    return itemType==null?false:itemType.startsWith('FileSignature');
  }

  bool get isSignatureNoDateTime{
    return itemType==null?false:itemType.startsWith('FileSignatureNoDateTime');
  }

  bool get isIdentity{
    return itemType==null?false:itemType.startsWith('Identity');
  }

  bool get isCheckListItem{
    return itemType==null?false:itemType.startsWith('CheckListItem');
  }

  bool get isMap{
    return itemType==null?false:itemType.startsWith('Map');
  }


  @override
  int get hashCode => eFormItemKey.hashCode;
  @override
  bool operator==(Object other) => other is EFormItem && other.eFormItemKey == eFormItemKey;

  factory EFormItem.fromJson(Map<String, dynamic> json) => _$EFormItemFromJson(json);

  factory EFormItem.fromJsonString(String s){
    return EFormItem.fromJson(jsonDecode(s));
  }

  factory EFormItem.empty(){
    return EFormItem()
        ..eFormItemKey=''
        ..itemLabel=''
        ;
  }

  Map<String, dynamic> toJson() => _$EFormItemToJson(this);
}

@JsonSerializable()
class EFormItemValuesOptionItem{
  String v;
  String t;

  int get hashCode => v.hashCode;
  bool operator==(Object other) => other is EFormItemValuesOptionItem && other.v == v;

  EFormItemValuesOptionItem();
  factory EFormItemValuesOptionItem.fromJson(Map<String, dynamic> json) => _$EFormItemValuesOptionItemFromJson(json);

  Map<String, dynamic> toJson() => _$EFormItemValuesOptionItemToJson(this);
}

@JsonSerializable()
class EFormItemValuesOption{

  EFormItemValuesOption();

  bool isSingle = false;
  List<EFormItemValuesOptionItem> list;

  bool containInList(String v){

    for(final item in list) {
      if ( item.v == v){
        return true;
      }
    }

    return false;

  }

  void addToList(String v){
    if (list==null) list = List();

    bool canAdd = !containInList(v);

    if (canAdd){
      list.add(EFormItemValuesOptionItem()..v=v..t=v);
    }
  }

  EFormItemValuesOptionItem getNextItemInList(String v){

    if (list==null) return null;
    if (list.length ==0) return null;

    if (list.length ==1) return list[0];

    EFormItemValuesOptionItem outPutItem ;

    for(int i =0;i <  list.length;i++) {
      final item = list[i];
      if (item.v == v){
        if (i==list.length -1){
          outPutItem = list[0];
        }else{
          outPutItem = list[i+1];
        }
        break;
      }
    }

    return outPutItem;
  }


  EFormItemValuesOptionItem getItemByValue(String v){
    if (list==null) return null;
    for(final i in list){
      if (i.v == v) return i;
    }

    if (list.length > 0) return list[0];
    return null;
  }

  factory EFormItemValuesOption.fromJson(Map<String, dynamic> json) => _$EFormItemValuesOptionFromJson(json);
  Map<String, dynamic> toJson() => _$EFormItemValuesOptionToJson(this);
}


