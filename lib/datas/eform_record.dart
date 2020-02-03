import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'eform_item.dart';
import 'package:intl/intl.dart';

import 'eform_item_section.dart';
import 'eform_record_user_activity.dart';
import 'eform_user_right.dart';


part 'eform_record.g.dart';

@JsonSerializable()

class EFormRecord  {
  EFormRecord();
  String eFormKey;
  String eFormRecordID;
  int eFormItemCurrentSection;
  String recordStatusLabel;

  DateTime createDate;
  String createBy;
  DateTime modifyDate;
  String modifyBy;
  String tempDescription;

  String fromLoginName;
  String toLoginName;

  EFormUserRight currentSectionRight;

  List<EFormItemSectionAction> actionListPrivate;

  String get modifyDateString{
    return modifyDate==null?'':DateFormat('yyyy-MM-dd kk:mm').format(modifyDate);
  }

  List<EFormRecordDetail> itemDetailList;
  List< EFormRecordUserActivity> activityList;
  List< EFormItemSection> sectionList;


  EFormItemSection get currentSectionObject{
    if (sectionList==null) return null;
    for(final s in sectionList){
      if (s.section == eFormItemCurrentSection) return s;
    }
    return null;
  }



  List<EFormItemSectionAction> get  currentActionList{
    if (currentSectionObject == null) return List<EFormItemSectionAction>();
    return currentSectionObject.actionList;
  }


  bool  isCurrentSection(EFormItemSection s){
    return s.section== this.eFormItemCurrentSection;
  }

  factory EFormRecord.fromJson(Map<String, dynamic> json) => _$EFormRecordFromJson(json);

  factory EFormRecord.fromJsonString(String s){
    return EFormRecord.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$EFormRecordToJson(this);
}


@JsonSerializable()
class EFormRecordDetail extends EFormItem {
  EFormRecordDetail();
  String eFormRecordID;

  String itemValue;
  double itemValueDecimal;
  DateTime itemValueDateTime;
  String itemPath;
  String itemThumbPath;

  String itemPathServer;

  DateTime createDate;
  String createBy;
  DateTime modifyDate;
  String modifyBy;



  @JsonKey(ignore: true)
  bool fileIsChanged=false;
  @JsonKey(ignore: true)
  bool hasFileTemp = true;

  bool get hasFile {
    if (!(hasFileTemp??true)) return false;

    return (itemPath??'')!='';
  }

  void setFile(String fileFullPath){
    fileIsChanged = true;
    if ((fileFullPath??'').isEmpty){
      this.itemValue = fileFullPath;
      this.itemPath = fileFullPath;
      this.itemValueDateTime = null;
      this.itemValueDecimal = 0;
    }else{
      this.itemValue = fileFullPath != null ? fileFullPath.split('/').last : null;
      this.itemPath = fileFullPath;
    }
    this.itemValueDateTime = DateTime.now();
  }

  get getValue {
    if (itemType == null) return itemValue;
    if (isDate) {

      if (itemValueDateTime == null) {
         return '';
      }
      return DateFormat('yyyy-MM-dd kk:mm').format(itemValueDateTime);
    }
    if (itemType == 'Decimal') return itemValueDecimal;
    if (itemType.startsWith('File')) return itemPath;

    return itemValue;
  }

  String get getDateTimeValueString{
    if (itemValueDateTime==null) return '';
    return DateFormat('yyyy-MM-dd kk:mm').format(itemValueDateTime);
  }


  factory EFormRecordDetail.fromJson(Map<String, dynamic> json) =>
      _$EFormRecordDetailFromJson(json);

  factory EFormRecordDetail.fromJsonString(String s) {
    return EFormRecordDetail.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$EFormRecordDetailToJson(this);
}
