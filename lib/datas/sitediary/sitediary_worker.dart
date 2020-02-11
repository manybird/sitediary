import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sitediary/datas/user.dart';
import 'sitediary_list_object.dart';
import 'sitediary_record_object.dart';

part 'sitediary_worker.g.dart';
// ignore_for_file: non_constant_identifier_names

@JsonSerializable()
class SiteDiaryWorker {

  //P0
  List<ContractCode> contractCodeList=[];
  List<SDTeam> teamList=[];
  List<User> staffList =[];

  //P1
  ContractCode selectedContract;
  User selectedUser;
  SDTeam selectedTeam;
  String ContractNo;
  DateTime RecordDate;

  String getDateInString(DateTime d){
    if (d==null) return '';
    return DateFormat('yyyy-MM-dd').format(d);
  }
  String getDateTimeInString(DateTime d){
    if (d==null) return '';
    return DateFormat('yyyy-MM-dd kk:mm').format(d);
  }
  String get getRecordDateString{
     return getDateInString(this.RecordDate);
  }

  String team;

  List<SDAreaList> areaList;
  List<SDLocList> locationList;
  List<SDStreetList> streetList;
  List<SDLocReserve1List> reserve1List;
  List<SDLocReserve2List> reserve2List;

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
    return 'Contract: ${contractCodeList?.length}'
        +', Team: ${teamList?.length}'
        +', staffList: ${staffList?.length}'
        +', lastReloadDataDate: ${lastReloadDataDate?.toIso8601String()}'
    ;
  }

  DateTime lastReloadDataDate;
  bool get isNeedReloadData{
    if (lastReloadDataDate ==null) return true;

    Duration dif = lastReloadDataDate.difference(DateTime.now());
    return dif.inHours >1;

  }
}