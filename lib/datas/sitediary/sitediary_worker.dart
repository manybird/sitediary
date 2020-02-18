import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sitediary/datas/user.dart';
import 'sitediary_list_object.dart';
import 'sitediary_record_object.dart';

part 'sitediary_worker.g.dart';
// ignore_for_file: non_constant_identifier_names

@JsonSerializable()
class SiteDiaryWorker {

  String getDateInString(DateTime d){
    if (d==null) return '';
    return DateFormat('yyyy-MM-dd').format(d);
  }
  String getDateTimeInString(DateTime d){
    if (d==null) return '';
    return DateFormat('yyyy-MM-dd kk:mm').format(d);
  }

  //P0
  List<ContractCode> contractCodeList=[];
  List<SDTeam> teamList=[];
  List<User> staffList =[];

  //P1
  DateTime RecordDate;
  ContractCode selectedContract;
  User selectedUser;
  SDTeam selectedTeam;

  bool isFreeze;
  bool isAbleToFreeze;
  String get getRecordDateString{
     return getDateInString(this.RecordDate);
  }

  List<SDLocationRecord> locationRecordList;

  List<SDAreaList> areaList;
  List<SDLocList> locList;
  List<SDLocList> locListByArea(String area){
    if (locList ==null) return null;
    return locList.where((SDLocList loc){
      return loc.Area == area;
    }).toList(growable: false);
  }

  List<SDWOList> woList;
  List<SDWOList> woListByArea(String area){
    if (woList ==null) return null;
    return woList.where((SDWOList loc){
      return loc.WOArea == area;
    }).toList(growable: false);
  }

  List<SDStreetList> streetList;
  List<SDLocReserve1List> reserve1List;
  List<SDLocReserve2List> reserve2List;

  List<SDSubContractorList> subContractorList;

  //P2
  List<SDActivityList> activityList;
  SDLocationRecord locationObject;


  //P3
  SDActivityRecord activityObject;
  List<SDLabourList> labourList;
  List<SDPlantList> plantList;

  //P4
  SDLabourRecord labourObject;
  List<SDLabourExtList> labourExtList;
  SDPlantRecord plantObject;

  //P5
  SDLabourExtRecord labourExtObject;

  SiteDiaryWorker();
  factory SiteDiaryWorker.fromJson(Map<String, dynamic> json) =>
      _$SiteDiaryWorkerFromJson(json);
  Map<String, dynamic> toJson() => _$SiteDiaryWorkerToJson(this);

  String debugString() {
    // TODO: implement toString
    return '[SiteDiaryWorker], Contract: ${contractCodeList?.length}'
        +', Team: ${teamList?.length}'
        +', staffList: ${staffList?.length}'
        +', lastReloadBaseDataDate: $lastReloadBaseDataDate'
        +', lastReloadLocationListDate: $lastReloadLocationListDate'
    ;
  }

  bool isNeedReload(DateTime d){
    if (d ==null) return true;
    Duration dif = d.difference(DateTime.now());
    return dif.inHours >1;
  }

  DateTime lastReloadBaseDataDate;
  bool get isNeedReloadBaseData=> isNeedReload(this.lastReloadBaseDataDate);

  DateTime lastReloadLocationListDate;
  bool get isNeedReloadLocationList=> isNeedReload(this.lastReloadLocationListDate);

}