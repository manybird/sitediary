

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
  List<SDActivityRecord> activityRecordList;

  List<SDAreaList> areaList;
  void areaListAdd(String area, String team){
    if (areaList ==null) return ;
    for (final w in areaList){
      if (w.Area ==area && w.Area==area){
        return;
      }
    }
    final nWo = SDAreaList()
      ..Area=area..Team = team;
    locList.add(nWo);
  }
  List<SDLocList> locList;
  void locListAdd(String area, String v){
    if (locList ==null) return ;
    for (final w in locList){
      if (((w.LocList??'') ==(v??'')) && ((w.Area??'')==(area??''))){
        return;
      }
    }
    final obj = SDLocList()
      ..Area=area..LocList = v;
    if ((v??'')=='') locList.insert(0,obj);
    else locList.add(obj);
  }
  List<SDLocList> locListByArea(String area){
    if (locList ==null) return null;
    return locList.where((SDLocList loc){
      return loc.Area == area;
    }).toList(growable: false);
  }

  List<SDWOList> woList;
  void woListAdd(String area, String v){
    if (woList ==null) return ;
    for (final w in woList){
      if ((w.WO??'') ==(v??'') && (w.WOArea??'')==(area??'')){
        return;
      }
    }
    final obj = SDWOList.fromEmpty()
      ..WOArea=area..WO = v..ActualWO=v;
    woList.add(obj);
  }
  List<SDWOList> woListByArea(String area){
    if (woList ==null) return null;
    return woList.where((SDWOList loc){
      return loc.WOArea == area;
    }).toList(growable: false);
  }

  List<SDStreetList> streetList;
  void streetListAdd(String area,String loc, String street){
    if (streetList ==null) return ;
    for (final w in streetList){
      if (((w.LocList??'') ==(loc??'')) && ((w.Area??'')==(area??'')) && ((w.Street??'')==(street??''))){
        return;
      }
    }
    final obj = SDStreetList()
      ..Area=area..LocList = loc..Street=street;

    if ((street??'')=='') streetList.insert(0,obj);
    else streetList.add(obj);

    //print('streetListAdd, area: $area, loc: $loc, street: $street');
  }
  List<SDStreetList> streetListBy(String area, String loc){
    if (streetList ==null) return null;
    final oList = streetList.where((SDStreetList obj){
      return obj.Area == area && obj.LocList == loc;
    }).toList(growable: false);
   // print('area: $area, loc: $loc, oList.length: ${oList.length}');
    return oList;
  }

  List<SDLocReserve1List> reserve1List;
  void reserve1ListAdd(String area,String loc, String street1, String reserve1){
    if (reserve1List ==null) return ;
    for (final w in reserve1List){
      if (((w.LocList??'') ==(loc??'')) && ((w.Area??'')==(area??'')) && ((w.Street??'')==(street1??'')) && ((w.Reserve1??'')==(reserve1??''))){
        return;
      }
    }
    final obj =SDLocReserve1List()
      ..Area=area..LocList = loc..Street=street1..Reserve1=reserve1;

    if (reserve1==null ||reserve1=='') reserve1List.insert(0, obj);
    else reserve1List.add(    obj );
    print('reserve1ListAdd, reserve1: $reserve1');

  }
  List<SDLocReserve1List> reserve1ListBy(String area, String loc, String street1){
    if (reserve1List ==null) return null;
    return reserve1List.where((SDLocReserve1List obj){
      return obj.Area == area && obj.LocList == loc && obj.Street == street1;
    }).toList(growable: false);
  }

  List<SDLocReserve2List> reserve2List;
  void reserve2ListAdd(String area,String loc, String street1, String reserve1, String reserve2){
    if (reserve2List ==null) return ;
    for (final w in reserve2List){
      if (((w.LocList??'') ==(loc??'')) && ((w.Area??'')==(area??'')) && ((w.Street??'')==(street1??'')) && ((w.Reserve1??'')==(reserve1??''))&& ((w.Reserve2??'')==(reserve2??''))){
        return;
      }
    }
    final obj = SDLocReserve2List()
      ..Area=area..LocList = loc..Street=street1..Reserve1=reserve1..Reserve2 = reserve2;
    if (reserve2==null ||reserve2=='') reserve2List.insert(0, obj);
    else reserve2List.add(    obj );
  }
  List<SDLocReserve2List> reserve2ListBy(String area, String loc, String street1, String reserve1){
    if (reserve2List ==null) return null;
    return reserve2List.where((SDLocReserve2List obj){
      return obj.Area == area && obj.LocList == loc && obj.Street == street1 && obj.Reserve1 == reserve1;
    }).toList(growable: false);
  }

  List<SDSubContractorList> subContractorList;
  void subContractorListAdd(String v){
    if (subContractorList ==null) return ;
    for (final w in subContractorList){
      if (w.SubContractor ==v){
        return;
      }
    }
    final nWo = SDSubContractorList()
      ..SubContractor=v;
    subContractorList.add(nWo);
  }
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

  SiteDiaryWorker getWorkerForRequest (){
    final o = this;
    final n = SiteDiaryWorker();
    n.RecordDate = o.RecordDate;
    n.selectedContract = o.selectedContract;
    n.selectedUser = o.selectedUser;
    n.selectedTeam = o.selectedTeam;
    n.isFreeze = o.isFreeze;
    n.isAbleToFreeze = o.isAbleToFreeze;
    n.locationObject = o.locationObject;
    n.activityObject = o.activityObject;
    n.labourObject = o.labourObject;
    n.plantObject = o.plantObject;
    n.labourExtObject = o.labourExtObject;

    return n;
  }

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