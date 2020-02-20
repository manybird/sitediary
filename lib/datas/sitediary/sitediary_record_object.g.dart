// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitediary_record_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDRecordBase _$SDRecordBaseFromJson(Map<String, dynamic> json) {
  return SDRecordBase()
    ..ContractNo = json['ContractNo'] as String
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..LastUpdateName = json['LastUpdateName'] as String
    ..OwnerName = json['OwnerName'] as String
    ..LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String)
    ..CreateDate = json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String)
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String;
}

Map<String, dynamic> _$SDRecordBaseToJson(SDRecordBase instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'LastUpdateName': instance.LastUpdateName,
      'OwnerName': instance.OwnerName,
      'LastUpdateDate': instance.LastUpdateDate?.toIso8601String(),
      'CreateDate': instance.CreateDate?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle
    };

SDLocationRecord _$SDLocationRecordFromJson(Map<String, dynamic> json) {
  return SDLocationRecord()
    ..ContractNo = json['ContractNo'] as String
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..LastUpdateName = json['LastUpdateName'] as String
    ..OwnerName = json['OwnerName'] as String
    ..LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String)
    ..CreateDate = json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String)
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..LocationID = json['LocationID'] as int
    ..WorkOrderNO = json['WorkOrderNO'] as String
    ..Area = json['Area'] as String
    ..Location = json['Location'] as String
    ..Street1 = json['Street1'] as String
    ..Street2 = json['Street2'] as String
    ..Street3 = json['Street3'] as String
    ..Street4 = json['Street4'] as String
    ..Reserve1 = json['Reserve1'] as String
    ..Reserve2 = json['Reserve2'] as String
    ..Section = json['Section'] as String
    ..SubContractor = json['SubContractor'] as String
    ..TeamPrefix = json['TeamPrefix'] as String
    ..Updated = json['Updated'] as bool
    ..lastReloadActivityListDate = json['lastReloadActivityListDate'] == null
        ? null
        : DateTime.parse(json['lastReloadActivityListDate'] as String);
}

Map<String, dynamic> _$SDLocationRecordToJson(SDLocationRecord instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'LastUpdateName': instance.LastUpdateName,
      'OwnerName': instance.OwnerName,
      'LastUpdateDate': instance.LastUpdateDate?.toIso8601String(),
      'CreateDate': instance.CreateDate?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'LocationID': instance.LocationID,
      'WorkOrderNO': instance.WorkOrderNO,
      'Area': instance.Area,
      'Location': instance.Location,
      'Street1': instance.Street1,
      'Street2': instance.Street2,
      'Street3': instance.Street3,
      'Street4': instance.Street4,
      'Reserve1': instance.Reserve1,
      'Reserve2': instance.Reserve2,
      'Section': instance.Section,
      'SubContractor': instance.SubContractor,
      'TeamPrefix': instance.TeamPrefix,
      'Updated': instance.Updated,
      'lastReloadActivityListDate':
          instance.lastReloadActivityListDate?.toIso8601String()
    };

SDActivityRecord _$SDActivityRecordFromJson(Map<String, dynamic> json) {
  return SDActivityRecord()
    ..ContractNo = json['ContractNo'] as String
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..LastUpdateName = json['LastUpdateName'] as String
    ..OwnerName = json['OwnerName'] as String
    ..LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String)
    ..CreateDate = json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String)
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..LocationID = json['LocationID'] as int
    ..ActivityID = json['ActivityID'] as int
    ..TypeOfWork = json['TypeOfWork'] as String
    ..SubActivity = json['SubActivity'] as String
    ..Activity = json['Activity'] as String
    ..RefTypeOfWork = json['RefTypeOfWork'] as String
    ..RefActivity = json['RefActivity'] as String
    ..RefActivityCode = json['RefActivityCode'] as String
    ..Time = json['Time'] as String
    ..SupervisedBy = json['SupervisedBy'] as String
    ..Remarks = json['Remarks'] as String
    ..Attachments = json['Attachments'] as String
    ..Description = json['Description'] as String;
}

Map<String, dynamic> _$SDActivityRecordToJson(SDActivityRecord instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'LastUpdateName': instance.LastUpdateName,
      'OwnerName': instance.OwnerName,
      'LastUpdateDate': instance.LastUpdateDate?.toIso8601String(),
      'CreateDate': instance.CreateDate?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'LocationID': instance.LocationID,
      'ActivityID': instance.ActivityID,
      'TypeOfWork': instance.TypeOfWork,
      'SubActivity': instance.SubActivity,
      'Activity': instance.Activity,
      'RefTypeOfWork': instance.RefTypeOfWork,
      'RefActivity': instance.RefActivity,
      'RefActivityCode': instance.RefActivityCode,
      'Time': instance.Time,
      'SupervisedBy': instance.SupervisedBy,
      'Remarks': instance.Remarks,
      'Attachments': instance.Attachments,
      'Description': instance.Description
    };

SDPlantRecord _$SDPlantRecordFromJson(Map<String, dynamic> json) {
  return SDPlantRecord()
    ..ContractNo = json['ContractNo'] as String
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..LastUpdateName = json['LastUpdateName'] as String
    ..OwnerName = json['OwnerName'] as String
    ..LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String)
    ..CreateDate = json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String)
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..ActivityID = json['ActivityID'] as int
    ..PlantID = json['PlantID'] as int
    ..PlantName = json['PlantName'] as String
    ..WorkingHour = json['WorkingHour'] as String
    ..PlantWorkingNo = json['PlantWorkingNo'] as String
    ..PlantWorkingID = json['PlantWorkingID'] as String
    ..PlantIdleNo = json['PlantIdleNo'] as String
    ..PlantIdleCode = json['PlantIdleCode'] as String
    ..SupplementaryInformation = json['SupplementaryInformation'] as String
    ..Remarks = json['Remarks'] as String
    ..Reason = json['Reason'] as String
    ..Ownership = json['Ownership'] as String;
}

Map<String, dynamic> _$SDPlantRecordToJson(SDPlantRecord instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'LastUpdateName': instance.LastUpdateName,
      'OwnerName': instance.OwnerName,
      'LastUpdateDate': instance.LastUpdateDate?.toIso8601String(),
      'CreateDate': instance.CreateDate?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'ActivityID': instance.ActivityID,
      'PlantID': instance.PlantID,
      'PlantName': instance.PlantName,
      'WorkingHour': instance.WorkingHour,
      'PlantWorkingNo': instance.PlantWorkingNo,
      'PlantWorkingID': instance.PlantWorkingID,
      'PlantIdleNo': instance.PlantIdleNo,
      'PlantIdleCode': instance.PlantIdleCode,
      'SupplementaryInformation': instance.SupplementaryInformation,
      'Remarks': instance.Remarks,
      'Reason': instance.Reason,
      'Ownership': instance.Ownership
    };

SDLabourRecord _$SDLabourRecordFromJson(Map<String, dynamic> json) {
  return SDLabourRecord()
    ..ContractNo = json['ContractNo'] as String
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..LastUpdateName = json['LastUpdateName'] as String
    ..OwnerName = json['OwnerName'] as String
    ..LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String)
    ..CreateDate = json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String)
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..ActivityID = json['ActivityID'] as int
    ..LabourID = json['LabourID'] as int
    ..StaffName = json['StaffName'] as String
    ..WorkingHour = json['WorkingHour'] as String
    ..Code = json['Code'] as String
    ..StaffNo = json['StaffNo'] as String
    ..StaffID = json['StaffID'] as String
    ..SupplementaryInformation = json['SupplementaryInformation'] as String
    ..Remarks = json['Remarks'] as String
    ..LabourExtKey = json['LabourExtKey'] as String;
}

Map<String, dynamic> _$SDLabourRecordToJson(SDLabourRecord instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'LastUpdateName': instance.LastUpdateName,
      'OwnerName': instance.OwnerName,
      'LastUpdateDate': instance.LastUpdateDate?.toIso8601String(),
      'CreateDate': instance.CreateDate?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'ActivityID': instance.ActivityID,
      'LabourID': instance.LabourID,
      'StaffName': instance.StaffName,
      'WorkingHour': instance.WorkingHour,
      'Code': instance.Code,
      'StaffNo': instance.StaffNo,
      'StaffID': instance.StaffID,
      'SupplementaryInformation': instance.SupplementaryInformation,
      'Remarks': instance.Remarks,
      'LabourExtKey': instance.LabourExtKey
    };

SDLabourExtRecord _$SDLabourExtRecordFromJson(Map<String, dynamic> json) {
  return SDLabourExtRecord()
    ..ContractNo = json['ContractNo'] as String
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..LastUpdateName = json['LastUpdateName'] as String
    ..OwnerName = json['OwnerName'] as String
    ..LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String)
    ..CreateDate = json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String)
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..LabourID = json['LabourID'] as int
    ..LabourExtID = json['LabourExtID'] as int
    ..LabourExtKey = json['LabourExtKey'] as String
    ..LabourName = json['LabourName'] as String
    ..Contractor = json['Contractor'] as String
    ..Company = json['Company'] as String
    ..Description = json['Description'] as String
    ..WorkingHour = json['WorkingHour'] as String
    ..Remarks = json['Remarks'] as String;
}

Map<String, dynamic> _$SDLabourExtRecordToJson(SDLabourExtRecord instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'LastUpdateName': instance.LastUpdateName,
      'OwnerName': instance.OwnerName,
      'LastUpdateDate': instance.LastUpdateDate?.toIso8601String(),
      'CreateDate': instance.CreateDate?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'LabourID': instance.LabourID,
      'LabourExtID': instance.LabourExtID,
      'LabourExtKey': instance.LabourExtKey,
      'LabourName': instance.LabourName,
      'Contractor': instance.Contractor,
      'Company': instance.Company,
      'Description': instance.Description,
      'WorkingHour': instance.WorkingHour,
      'Remarks': instance.Remarks
    };

SDMaterialRecord _$SDMaterialRecordFromJson(Map<String, dynamic> json) {
  return SDMaterialRecord()
    ..ContractNo = json['ContractNo'] as String
    ..RecordDate = json['RecordDate'] == null
        ? null
        : DateTime.parse(json['RecordDate'] as String)
    ..LastUpdateName = json['LastUpdateName'] as String
    ..OwnerName = json['OwnerName'] as String
    ..LastUpdateDate = json['LastUpdateDate'] == null
        ? null
        : DateTime.parse(json['LastUpdateDate'] as String)
    ..CreateDate = json['CreateDate'] == null
        ? null
        : DateTime.parse(json['CreateDate'] as String)
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..ActivityID = json['ActivityID'] as int
    ..MaterialID = json['MaterialID'] as int
    ..Description = json['Description'] as String
    ..WorkingHour = json['WorkingHour'] as String
    ..Quantity = json['Quantity'] as String
    ..Unit = json['Unit'] as String;
}

Map<String, dynamic> _$SDMaterialRecordToJson(SDMaterialRecord instance) =>
    <String, dynamic>{
      'ContractNo': instance.ContractNo,
      'RecordDate': instance.RecordDate?.toIso8601String(),
      'LastUpdateName': instance.LastUpdateName,
      'OwnerName': instance.OwnerName,
      'LastUpdateDate': instance.LastUpdateDate?.toIso8601String(),
      'CreateDate': instance.CreateDate?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'ActivityID': instance.ActivityID,
      'MaterialID': instance.MaterialID,
      'Description': instance.Description,
      'WorkingHour': instance.WorkingHour,
      'Quantity': instance.Quantity,
      'Unit': instance.Unit
    };
