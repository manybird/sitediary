// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitediary_worker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteDiaryWorker _$SiteDiaryWorkerFromJson(Map<String, dynamic> json) {
  return SiteDiaryWorker()
    ..contractCodeList = (json['contractCodeList'] as List)
        ?.map((e) =>
            e == null ? null : ContractCode.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..teamList = (json['teamList'] as List)
        ?.map((e) =>
            e == null ? null : SDTeam.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..staffList = (json['staffList'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..selectedContract = json['selectedContract'] == null
        ? null
        : ContractCode.fromJson(
            json['selectedContract'] as Map<String, dynamic>)
    ..selectedUser = json['selectedUser'] == null
        ? null
        : User.fromJson(json['selectedUser'] as Map<String, dynamic>)
    ..selectedTeam = json['selectedTeam'] == null
        ? null
        : SDTeam.fromJson(json['selectedTeam'] as Map<String, dynamic>)
    ..isFreeze = json['isFreeze'] as bool
    ..isAbleToFreeze = json['isAbleToFreeze'] as bool
    ..locationRecordList = (json['locationRecordList'] as List)
        ?.map((e) => e == null
            ? null
            : SDLocationRecord.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..areaList = (json['areaList'] as List)
        ?.map((e) =>
            e == null ? null : SDAreaList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..locList = (json['locList'] as List)
        ?.map((e) =>
            e == null ? null : SDLocList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..woList = (json['woList'] as List)
        ?.map((e) =>
            e == null ? null : SDWOList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..streetList = (json['streetList'] as List)
        ?.map((e) =>
            e == null ? null : SDStreetList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..reserve1List = (json['reserve1List'] as List)
        ?.map((e) => e == null
            ? null
            : SDLocReserve1List.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..reserve2List = (json['reserve2List'] as List)
        ?.map((e) => e == null
            ? null
            : SDLocReserve2List.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..subContractorList = (json['subContractorList'] as List)
        ?.map((e) => e == null
            ? null
            : SDSubContractorList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..activityList = (json['activityList'] as List)
        ?.map(
            (e) => e == null ? null : SDActivityList.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..locationObject = json['locationObject'] == null ? null : SDLocationRecord.fromJson(json['locationObject'] as Map<String, dynamic>)
    ..activityObject = json['activityObject'] == null ? null : SDActivityRecord.fromJson(json['activityObject'] as Map<String, dynamic>)
    ..labourList = (json['labourList'] as List)?.map((e) => e == null ? null : SDLabourList.fromJson(e as Map<String, dynamic>))?.toList()
    ..plantList = (json['plantList'] as List)?.map((e) => e == null ? null : SDPlantList.fromJson(e as Map<String, dynamic>))?.toList()
    ..labourObject = json['labourObject'] == null ? null : SDLabourRecord.fromJson(json['labourObject'] as Map<String, dynamic>)
    ..labourExtList = (json['labourExtList'] as List)?.map((e) => e == null ? null : SDLabourExtList.fromJson(e as Map<String, dynamic>))?.toList()
    ..plantObject = json['plantObject'] == null ? null : SDPlantRecord.fromJson(json['plantObject'] as Map<String, dynamic>)
    ..labourExtObject = json['labourExtObject'] == null ? null : SDLabourExtRecord.fromJson(json['labourExtObject'] as Map<String, dynamic>)
    ..lastReloadBaseDataDate = json['lastReloadBaseDataDate'] == null ? null : DateTime.parse(json['lastReloadBaseDataDate'] as String)
    ..lastReloadLocationListDate = json['lastReloadLocationListDate'] == null ? null : DateTime.parse(json['lastReloadLocationListDate'] as String);
}

Map<String, dynamic> _$SiteDiaryWorkerToJson(SiteDiaryWorker instance) =>
    <String, dynamic>{
      'contractCodeList': instance.contractCodeList,
      'teamList': instance.teamList,
      'staffList': instance.staffList,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'selectedContract': instance.selectedContract,
      'selectedUser': instance.selectedUser,
      'selectedTeam': instance.selectedTeam,
      'isFreeze': instance.isFreeze,
      'isAbleToFreeze': instance.isAbleToFreeze,
      'locationRecordList': instance.locationRecordList,
      'areaList': instance.areaList,
      'locList': instance.locList,
      'woList': instance.woList,
      'streetList': instance.streetList,
      'reserve1List': instance.reserve1List,
      'reserve2List': instance.reserve2List,
      'subContractorList': instance.subContractorList,
      'activityList': instance.activityList,
      'locationObject': instance.locationObject,
      'activityObject': instance.activityObject,
      'labourList': instance.labourList,
      'plantList': instance.plantList,
      'labourObject': instance.labourObject,
      'labourExtList': instance.labourExtList,
      'plantObject': instance.plantObject,
      'labourExtObject': instance.labourExtObject,
      'lastReloadBaseDataDate':
          instance.lastReloadBaseDataDate?.toIso8601String(),
      'lastReloadLocationListDate':
          instance.lastReloadLocationListDate?.toIso8601String()
    };
