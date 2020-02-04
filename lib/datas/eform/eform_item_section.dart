import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'eform_record.dart';
import 'eform_user_right.dart';

part 'eform_item_section.g.dart';


@JsonSerializable()
class EFormItemSection {
  EFormItemSection();

  @JsonKey(ignore: true)
  bool isHidden=false;

  String eFormKey;
  int section;
  int mainSection;

  int sectionNext;
  String sectionLabel;
  String recordStatusLabel;

  bool isPrivateSection;
  bool isAssignSection;
  String assignSectionFormItemKey;
  bool isReplySection;

  List<EFormItemSectionDetail> detailList;
  List<EFormItemSectionAction> actionList;

  EFormUserRight formSectionRight;

  EFormRecordDetail canSaveCheck(){

    if (detailList==null) return null;

    final requiredGroup = new Map<int, List<EFormRecordDetail>>();
    final okGroup = List<int>();

    for (var i in detailList) {
      final r = i.recordDetail;
      if (r.isReadOnly) continue;
      final isRequired =r.isRequired??0;
      if (isRequired ==0 ) continue;

      if (isRequired > 1){

        if (okGroup.contains(isRequired)) continue;

        List<EFormRecordDetail> list = requiredGroup[isRequired] ;
        if (list==null){
          list = List<EFormRecordDetail>();
          requiredGroup[isRequired] = list;
        }

        if (r.isDate && r.itemValueDateTime !=null) {
         if (!okGroup.contains(isRequired)){
           okGroup.add(isRequired);
           requiredGroup.remove(isRequired);
           continue;
         }
        }else if (r.isFile && ((r.itemPath??'').isNotEmpty)){
          if (!okGroup.contains(isRequired)){
            okGroup.add(isRequired);
            requiredGroup.remove(isRequired);
            continue;
          }
        }else if ((r.itemValue??'').isNotEmpty){
          if (!okGroup.contains(isRequired)){
            okGroup.add(isRequired);
            requiredGroup.remove(isRequired);
            continue;
          }
        }

        list.add(r);
      }
      else{
        if (r.isDate && r.itemValueDateTime ==null) {
          return r;
        }else if (r.isFile && (r.itemPath == null || r.itemPath.isEmpty)){
          return r;
        }else if (r.itemValue==null || r.itemValue.isEmpty){
          return r;
        }
      }
    }

    for(final list in requiredGroup.values){
      for(final r in list){
        return  r;
      }
    }
    return null;

  }

  factory EFormItemSection.empty(){
    final sec =  EFormItemSection();
    sec.mainSection =-1;
    sec.sectionNext=-1;
    sec.isPrivateSection = false;
    sec.isAssignSection = false;
    sec.isReplySection = false;
    sec.isHidden = false;
    return  sec;
  }

  factory EFormItemSection.fromJson(Map<String, dynamic> json) => _$EFormItemSectionFromJson(json);

  factory EFormItemSection.fromJsonString(String s){
    return EFormItemSection.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$EFormItemSectionToJson(this);
}

@JsonSerializable()
class EFormItemSectionDetail {
  EFormItemSectionDetail();

  String eFormKey;
  int section;
  String eFormItemKey;

  EFormRecordDetail recordDetail;

  factory EFormItemSectionDetail.fromJson(Map<String, dynamic> json) => _$EFormItemSectionDetailFromJson(json);

  factory EFormItemSectionDetail.fromJsonString(String s){
    return EFormItemSectionDetail.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$EFormItemSectionDetailToJson(this);
}

@JsonSerializable()
class EFormItemSectionAction {
  EFormItemSectionAction({this.section,this.action,this.actionTargetSection});

  String eFormKey;
  int section=-1;
  int action=-1;
  int actionTargetSection=-1;
  String actionLabel;

  int actionType=-1;

  factory EFormItemSectionAction.empty(){
    return EFormItemSectionAction()..section=-1
    ..action=-1
    ..actionTargetSection = -1
    ..actionLabel='Save';
  }

  factory EFormItemSectionAction.fromJson(Map<String, dynamic> json) => _$EFormItemSectionActionFromJson(json);

  factory EFormItemSectionAction.fromJsonString(String s){
    return EFormItemSectionAction.fromJson(jsonDecode(s));
  }

  Map<String, dynamic> toJson() => _$EFormItemSectionActionToJson(this);
}

