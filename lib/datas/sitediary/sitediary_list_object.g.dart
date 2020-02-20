// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitediary_list_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDListBase _$SDListBaseFromJson(Map<String, dynamic> json) {
  return SDListBase()..tText = json['tText'] as String;
}

Map<String, dynamic> _$SDListBaseToJson(SDListBase instance) =>
    <String, dynamic>{'tText': instance.tText};

ContractCode _$ContractCodeFromJson(Map<String, dynamic> json) {
  return ContractCode()
    ..ContractNo = json['ContractNo'] as String
    ..Description = json['Description'] as String
    ..Reserve2 = json['Reserve2'] as String
    ..InOutType = json['InOutType'] as String
    ..Prefix = json['Prefix'] as String
    ..Length = json['Length'] as int
    ..isInputStaff = json['isInputStaff'] as bool
    ..isEditLock = json['isEditLock'] as bool
    ..isTeamControl = json['isTeamControl'] as bool
    ..isGroupByTeam = json['isGroupByTeam'] as bool
    ..teamList = (json['teamList'] as List)
        ?.map((e) =>
            e == null ? null : SDTeam.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ContractCodeToJson(ContractCode instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'Description': instance.Description,
      'Reserve2': instance.Reserve2,
      'InOutType': instance.InOutType,
      'Prefix': instance.Prefix,
      'Length': instance.Length,
      'isInputStaff': instance.isInputStaff,
      'isEditLock': instance.isEditLock,
      'isTeamControl': instance.isTeamControl,
      'isGroupByTeam': instance.isGroupByTeam,
      'teamList': instance.teamList
    };

SDActivityList _$SDActivityListFromJson(Map<String, dynamic> json) {
  return SDActivityList()
    ..tText = json['tText'] as String
    ..ListName = json['ListName'] as String
    ..TypeOfWork = json['TypeOfWork'] as String
    ..code = json['code'] as String;
}

Map<String, dynamic> _$SDActivityListToJson(SDActivityList instance) =>
    <String, dynamic>{
      'tText': instance.tText,
      'ListName': instance.ListName,
      'TypeOfWork': instance.TypeOfWork,
      'code': instance.code
    };

SDTeam _$SDTeamFromJson(Map<String, dynamic> json) {
  return SDTeam()
    ..Team = json['Team'] as String
    ..sign = json['sign'] as String;
}

Map<String, dynamic> _$SDTeamToJson(SDTeam instance) =>
    <String, dynamic>{'Team': instance.Team, 'sign': instance.sign};

SDPlantList _$SDPlantListFromJson(Map<String, dynamic> json) {
  return SDPlantList()
    ..tText = json['tText'] as String
    ..ListName = json['ListName'] as String
    ..ListDescription = json['ListDescription'] as String
    ..ListCode = json['ListCode'] as String;
}

Map<String, dynamic> _$SDPlantListToJson(SDPlantList instance) =>
    <String, dynamic>{
      'tText': instance.tText,
      'ListName': instance.ListName,
      'ListDescription': instance.ListDescription,
      'ListCode': instance.ListCode
    };

SDLabourList _$SDLabourListFromJson(Map<String, dynamic> json) {
  return SDLabourList()
    ..tText = json['tText'] as String
    ..ListName = json['ListName'] as String
    ..ListCode = json['ListCode'] as String;
}

Map<String, dynamic> _$SDLabourListToJson(SDLabourList instance) =>
    <String, dynamic>{
      'tText': instance.tText,
      'ListName': instance.ListName,
      'ListCode': instance.ListCode
    };

SDLabourExtList _$SDLabourExtListFromJson(Map<String, dynamic> json) {
  return SDLabourExtList()
    ..tText = json['tText'] as String
    ..LabourExtKey = json['LabourExtKey'] as String
    ..LabourName = json['LabourName'] as String
    ..Contractor = json['Contractor'] as String
    ..Company = json['Company'] as String
    ..Description = json['Description'] as String
    ..ListOrder = json['ListOrder'] as int;
}

Map<String, dynamic> _$SDLabourExtListToJson(SDLabourExtList instance) =>
    <String, dynamic>{
      'tText': instance.tText,
      'LabourExtKey': instance.LabourExtKey,
      'LabourName': instance.LabourName,
      'Contractor': instance.Contractor,
      'Company': instance.Company,
      'Description': instance.Description,
      'ListOrder': instance.ListOrder
    };

SDAreaList _$SDAreaListFromJson(Map<String, dynamic> json) {
  return SDAreaList(Area: json['Area'] as String, Team: json['Team'] as String);
}

Map<String, dynamic> _$SDAreaListToJson(SDAreaList instance) =>
    <String, dynamic>{'Area': instance.Area, 'Team': instance.Team};

SDLocList _$SDLocListFromJson(Map<String, dynamic> json) {
  return SDLocList(
      LocList: json['LocList'] as String,
      ListDescription: json['ListDescription'] as String)
    ..Area = json['Area'] as String
    ..Team = json['Team'] as String;
}

Map<String, dynamic> _$SDLocListToJson(SDLocList instance) => <String, dynamic>{
      'Area': instance.Area,
      'Team': instance.Team,
      'LocList': instance.LocList,
      'ListDescription': instance.ListDescription
    };

SDWOList _$SDWOListFromJson(Map<String, dynamic> json) {
  return SDWOList()
    ..ActualWO = json['ActualWO'] as String
    ..WO = json['WO'] as String
    ..WOArea = json['WOArea'] as String;
}

Map<String, dynamic> _$SDWOListToJson(SDWOList instance) => <String, dynamic>{
      'ActualWO': instance.ActualWO,
      'WO': instance.WO,
      'WOArea': instance.WOArea
    };

SDStreetList _$SDStreetListFromJson(Map<String, dynamic> json) {
  return SDStreetList(Street: json['Street'] as String)
    ..Area = json['Area'] as String
    ..Team = json['Team'] as String
    ..LocList = json['LocList'] as String
    ..ListDescription = json['ListDescription'] as String;
}

Map<String, dynamic> _$SDStreetListToJson(SDStreetList instance) =>
    <String, dynamic>{
      'Area': instance.Area,
      'Team': instance.Team,
      'LocList': instance.LocList,
      'ListDescription': instance.ListDescription,
      'Street': instance.Street
    };

SDLocReserve1List _$SDLocReserve1ListFromJson(Map<String, dynamic> json) {
  return SDLocReserve1List()
    ..Area = json['Area'] as String
    ..Team = json['Team'] as String
    ..LocList = json['LocList'] as String
    ..ListDescription = json['ListDescription'] as String
    ..Street = json['Street'] as String
    ..Reserve1 = json['Reserve1'] as String;
}

Map<String, dynamic> _$SDLocReserve1ListToJson(SDLocReserve1List instance) =>
    <String, dynamic>{
      'Area': instance.Area,
      'Team': instance.Team,
      'LocList': instance.LocList,
      'ListDescription': instance.ListDescription,
      'Street': instance.Street,
      'Reserve1': instance.Reserve1
    };

SDLocReserve2List _$SDLocReserve2ListFromJson(Map<String, dynamic> json) {
  return SDLocReserve2List()
    ..Area = json['Area'] as String
    ..Team = json['Team'] as String
    ..LocList = json['LocList'] as String
    ..ListDescription = json['ListDescription'] as String
    ..Street = json['Street'] as String
    ..Reserve1 = json['Reserve1'] as String
    ..Reserve2 = json['Reserve2'] as String;
}

Map<String, dynamic> _$SDLocReserve2ListToJson(SDLocReserve2List instance) =>
    <String, dynamic>{
      'Area': instance.Area,
      'Team': instance.Team,
      'LocList': instance.LocList,
      'ListDescription': instance.ListDescription,
      'Street': instance.Street,
      'Reserve1': instance.Reserve1,
      'Reserve2': instance.Reserve2
    };

SDSubContractorList _$SDSubContractorListFromJson(Map<String, dynamic> json) {
  return SDSubContractorList()..SubContractor = json['SubContractor'] as String;
}

Map<String, dynamic> _$SDSubContractorListToJson(
        SDSubContractorList instance) =>
    <String, dynamic>{'SubContractor': instance.SubContractor};
