import 'package:json_annotation/json_annotation.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';

part 'state_site_diary.g.dart';

@JsonSerializable()
class SiteDiaryState {
  SiteDiaryWorker currentSiteDiaryWorker;
  SiteDiaryState( this.currentSiteDiaryWorker);
  factory SiteDiaryState.initial(){
    return SiteDiaryState( SiteDiaryWorker() );
  }

  factory SiteDiaryState.fromJson(Map<String, dynamic> json) {
    return _$SiteDiaryStateFromJson(json);
  }

  dynamic toJson()=> _$SiteDiaryStateToJson (this);

  @override
  String toString() {
    return this.toString();
  }
}