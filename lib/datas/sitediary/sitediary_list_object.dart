import 'package:json_annotation/json_annotation.dart';
part 'sitediary_list_object.g.dart';
// ignore_for_file: non_constant_identifier_names

@JsonSerializable()
class SDListBase {
  String ContractNo;
  SDListBase();
  factory SDListBase.fromJson(Map<String, dynamic> json) =>
      _$SDListBaseFromJson(json);
  Map<String, dynamic> toJson() => _$SDListBaseToJson(this);

  String tText;
}
@JsonSerializable()
class ContractCode extends SDListBase {

  String Description ;
  String Reserve2 ;
  String InOutType ;
  String Prefix ;
  int Length ;

  /// site diary control below
  bool isInputStaff;
  bool isEditLock;
  bool isTeamControl;
  bool isGroupByTeam;
  List<SDTeam> teamList;

  ContractCode();

  factory ContractCode.fromEmpty() {
    return ContractCode()
      ..ContractNo=''..Description=''..teamList=List()
      ..isInputStaff=false..isEditLock=false..isTeamControl=false..isGroupByTeam=false;
  }

  @override
  int get hashCode => ContractNo.hashCode;
  @override
  bool operator==(Object other) => other is ContractCode && other.ContractNo == ContractNo;

  factory ContractCode.fromJson(Map<String, dynamic> json) =>
      _$ContractCodeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContractCodeToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return '$ContractNo - $Description - isInputStaff:$isInputStaff - isEditLock:$isEditLock - teamList: ${teamList?.length}';
  }

  @override
  String get tText{
   return this.Description??'';
  }
}


@JsonSerializable()
class SDActivityList extends SDListBase {
  String ListName; 
  String ListDescription;
  SDActivityList();
  factory SDActivityList.fromJson(Map<String, dynamic> json) =>
      _$SDActivityListFromJson(json);
  Map<String, dynamic> toJson() => _$SDActivityListToJson(this);
}
@JsonSerializable()
class SDTeam extends SDListBase {
  String Team; 
  String sign;
  SDTeam();
  factory SDTeam.fromJson(Map<String, dynamic> json) =>
      _$SDTeamFromJson(json);
  Map<String, dynamic> toJson() => _$SDTeamToJson(this);

  @override
  int get hashCode => Team.hashCode;
  @override
  bool operator==(Object other) => other is SDTeam && other.Team == Team;

  String get tText {
    return sign??'';
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.tText;
  }

}
@JsonSerializable()
class SDPlantList extends SDListBase {
  String ListName; 
  String ListDescription;
  String ListCode;
  SDPlantList();
  factory SDPlantList.fromJson(Map<String, dynamic> json) =>
      _$SDPlantListFromJson(json);
  Map<String, dynamic> toJson() => _$SDPlantListToJson(this);
}
@JsonSerializable()
class SDLabourList extends SDListBase {
  String ListName; 

  String ListCode;
  SDLabourList();
  factory SDLabourList.fromJson(Map<String, dynamic> json) =>
      _$SDLabourListFromJson(json);
  Map<String, dynamic> toJson() => _$SDLabourListToJson(this);
}

@JsonSerializable()
class SDLabourExtList extends SDListBase {
  String LabourExtKey; 
  String LabourName;
  String Contractor;
  String Company;
  String Description;
  int ListOrder;
  SDLabourExtList();
  factory SDLabourExtList.fromJson(Map<String, dynamic> json) =>
      _$SDLabourExtListFromJson(json);
  Map<String, dynamic> toJson() => _$SDLabourExtListToJson(this);
}

//Location below
@JsonSerializable()
class SDAreaList extends SDListBase {
  String Area ; 
  String Team ; 
  SDAreaList();
  factory SDAreaList.fromJson(Map<String, dynamic> json) =>
      _$SDAreaListFromJson(json);
  Map<String, dynamic> toJson() => _$SDAreaListToJson(this);
}
@JsonSerializable()
class SDLocList extends SDAreaList {
  String Loc ; 
  String ListDescription ; 
  SDLocList();
  factory SDLocList.fromJson(Map<String, dynamic> json) =>
      _$SDLocListFromJson(json);
  Map<String, dynamic> toJson() => _$SDLocListToJson(this);
}
@JsonSerializable()
class SDStreetList extends SDLocList {
  String Street ; 
  SDStreetList();
  factory SDStreetList.fromJson(Map<String, dynamic> json) =>
      _$SDStreetListFromJson(json);
  Map<String, dynamic> toJson() => _$SDStreetListToJson(this);
}
@JsonSerializable()
class SDLocReserve1List extends SDStreetList {
  String Reserve1 ; 
  SDLocReserve1List();
  factory SDLocReserve1List.fromJson(Map<String, dynamic> json) =>
      _$SDLocReserve1ListFromJson(json);
  Map<String, dynamic> toJson() => _$SDLocReserve1ListToJson(this);
}
@JsonSerializable()
class SDLocReserve2List extends SDLocReserve1List {
  String Reserve2 ; 
  SDLocReserve2List();
  factory SDLocReserve2List.fromJson(Map<String, dynamic> json) =>
      _$SDLocReserve2ListFromJson(json);
  Map<String, dynamic> toJson() => _$SDLocReserve2ListToJson(this);
}
