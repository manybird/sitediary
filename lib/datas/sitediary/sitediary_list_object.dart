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

  int get hashCode => this.toString().hashCode;
  bool operator==(Object other) => other is SDAreaList && other.toString() == this.toString();
  String toString() => this.Area;
  String get tText=> this.toString();
}
@JsonSerializable()
class SDLocList extends SDAreaList {
  String LocList ;
  String ListDescription ; 
  SDLocList();
  factory SDLocList.fromJson(Map<String, dynamic> json) =>
      _$SDLocListFromJson(json);
  Map<String, dynamic> toJson() => _$SDLocListToJson(this);

  int get hashCode => this.toString().hashCode;
  bool operator==(Object other) => other is SDLocList && other.toString() == this.toString();
  String toString() => this.LocList;
  String get tText=> this.toString();
  factory SDLocList.fromEmpty(){
    return SDLocList()..LocList='' ;

  }
}
@JsonSerializable()
class SDWOList extends SDListBase {
  String ActualWO ;
  String WO ;
  String WOArea ;
  SDWOList();
  factory SDWOList.fromEmpty(){
    return SDWOList()..WOArea=''
    ..ActualWO=''
    ..WO='';

  }
  factory SDWOList.fromJson(Map<String, dynamic> json) =>
      _$SDWOListFromJson(json);
  Map<String, dynamic> toJson() => _$SDWOListToJson(this);

  int get hashCode => this.toString().hashCode;
  bool operator==(Object other) => other is SDWOList && other.toString() == this.toString();
  String toString() => this.WO;
  String get tText=> this.ActualWO;

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

@JsonSerializable()
class SDSubContractorList extends SDListBase{
  String SubContractor;
  SDSubContractorList();
  factory SDSubContractorList.fromJson(Map<String, dynamic> json) =>
      _$SDSubContractorListFromJson(json);
  Map<String, dynamic> toJson() => _$SDSubContractorListToJson(this);

  //if (other is String) return other == SubContractor;

  int get hashCode => this.toString().hashCode;
  bool operator==(Object other) => other is SDSubContractorList && other.toString() == this.toString();
  String toString() => this.SubContractor;
  String get tText=> this.toString();

}