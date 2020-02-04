
import 'package:sitediary/datas/eform/eform_record.dart';

import 'package:json_annotation/json_annotation.dart';

part 'state_eform_record.g.dart';

@JsonSerializable()
class EFormRecordState {
  EFormRecord currentEFormRecord;
  EFormRecordState( this.currentEFormRecord);

  factory EFormRecordState.initial(){
    return EFormRecordState( EFormRecord() );
  }

  factory EFormRecordState.fromJson(Map<String, dynamic> json) {
    return _$EFormRecordStateFromJson(json);
  }

  dynamic toJson()=> _$EFormRecordStateToJson (this);
  @override
  String toString() {
    return 'EForm Record State: ${this.currentEFormRecord.tempDescription}';
  }

}