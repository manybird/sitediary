import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sitediary_record_object.g.dart';
// ignore_for_file: non_constant_identifier_names
@JsonSerializable()
class SDRecordBase {
  String ContractNo;
  DateTime RecordDate ;
  String LastUpdateName ;
  String OwnerName ;
  DateTime LastUpdateDate ;
  DateTime CreateDate ;

  String title;
  String subTitle;

  SDRecordBase();
  String getDateString(DateTime d){
    return d==null?'': DateFormat('yyyy-MM-dd').format(d);
  }
  String getDateTimeString(DateTime d){
    return d==null?'': DateFormat('yyyy-MM-dd kk:mm:ss').format(d);
  }
  factory SDRecordBase.fromJson(Map<String, dynamic> json) =>
      _$SDRecordBaseFromJson(json);
  Map<String, dynamic> toJson() => _$SDRecordBaseToJson(this);

  bool isNeedReload(DateTime d){
    if (d ==null) return true;
    Duration dif = d.difference(DateTime.now());
    return dif.inHours >1;
  }

}
@JsonSerializable()
class SDLocationRecord extends SDRecordBase {
  int LocationID;
  String WorkOrderNO ;
  String Area ;
  String Location ;
  String Street1 ;
  String Street2 ;
  String Street3 ;
  String Street4 ;
  String Reserve1 ;
  String Reserve2 ;

  String Section ;
  String SubContractor ;
  String TeamPrefix ;
  bool Updated;

  void resetReserve1(String v){
    final r = this;
    r.Reserve2 = null;
    r.Reserve1 = v;
  }
  void resetStreet1(String v){
    resetReserve1(null);
    Street1 = v;
  }
  void resetLocation(String v){
    final r = this;
    resetStreet1(null);
    r.Street2 = null;
    r.Street3 = null;
    r.Street4 = null;
    r.Location = v;
  }
  void resetArea(String v){
    resetLocation(null);
    final r = this;
    r.WorkOrderNO = null;
    r.Area = v;
  }

  SDLocationRecord();
  factory SDLocationRecord.fromJson(Map<String, dynamic> json) =>
      _$SDLocationRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SDLocationRecordToJson(this);

  DateTime lastReloadActivityListDate;
  bool get isNeedReloadLocationList=> isNeedReload(this.lastReloadActivityListDate);

}
@JsonSerializable()
class SDActivityRecord  extends SDRecordBase{
  int LocationID;
  int ActivityID;
  String TypeOfWork ;
  String SubActivity ;
  String Activity ;
  String RefTypeOfWork ;
  String RefActivity ;
  String RefActivityCode ;
  String Time ;
  String SupervisedBy ;
  String Remarks ;

  String Attachments ;
  String Description ;

  SDActivityRecord();
  factory SDActivityRecord.fromJson(Map<String, dynamic> json) =>
      _$SDActivityRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SDActivityRecordToJson(this);

}
@JsonSerializable()
class SDPlantRecord  extends SDRecordBase{
  int ActivityID;
  int PlantID;

  String PlantName ;
  String WorkingHour ;
  String PlantWorkingNo ;
  String PlantWorkingID ;
  String PlantIdleNo ;
  String PlantIdleCode ;
  String SupplementaryInformation ;
  String Remarks ;
  String Reason ;
  String Ownership ;

  SDPlantRecord();
  factory SDPlantRecord.fromJson(Map<String, dynamic> json) =>
      _$SDPlantRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SDPlantRecordToJson(this);

}
@JsonSerializable()
class SDLabourRecord  extends SDRecordBase{
  int ActivityID;
  int LabourID;

  String StaffName ;
  String WorkingHour ;
  String Code ;
  String StaffNo ;
  String StaffID ;
  String SupplementaryInformation ;
  String Remarks ;
  String LabourExtKey ;
  SDLabourRecord();
  factory SDLabourRecord.fromJson(Map<String, dynamic> json) =>
      _$SDLabourRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SDLabourRecordToJson(this);
}
@JsonSerializable()
class SDLabourExtRecord  extends SDRecordBase {
  int LabourID;
  int LabourExtID;

  String LabourExtKey;
  String LabourName;
  String Contractor;
  String Company;
  String Description;
  String WorkingHour;
  String Remarks;
  SDLabourExtRecord();

  factory SDLabourExtRecord.fromJson(Map<String, dynamic> json) =>
      _$SDLabourExtRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SDLabourExtRecordToJson(this);
}
@JsonSerializable()
class SDMaterialRecord  extends SDRecordBase {
  int ActivityID;
  int MaterialID;

  String Description;
  String WorkingHour;
  String Quantity;
  String Unit;

  SDMaterialRecord();

  factory SDMaterialRecord.fromJson(Map<String, dynamic> json) =>
      _$SDMaterialRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SDMaterialRecordToJson(this);
}