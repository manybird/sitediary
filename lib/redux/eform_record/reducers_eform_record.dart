import 'package:sitediary/datas/eform_record.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:sitediary/redux/eform_record/state_eform_record.dart';

import 'package:redux/redux.dart';



EFormRecordState eFormRecordReducer(EFormRecordState state, action) {
  return EFormRecordState(
      _eFormRecordReducer(state.currentEFormRecord, action)
  );
}

final Reducer<EFormRecord> _eFormRecordReducer = combineReducers<EFormRecord>([
  TypedReducer<EFormRecord,UpdateFormItemDetailAction>((EFormRecord eFormRecord,UpdateFormItemDetailAction action){

    final currentSection = eFormRecord.currentSectionObject;

    if (currentSection==null) {
      print('currentSectionObject is null');
    }
    else
    {
      var r = action.recordDetail;
      for (final d in currentSection.detailList){
        if (d.eFormItemKey == action.recordDetail.eFormItemKey){
          d.recordDetail.itemValue = r.itemValue;
          d.recordDetail.itemValueDateTime = r.itemValueDateTime;
          d.recordDetail.itemValueDecimal = r.itemValueDecimal;
          break;
        }
      }
    }
    return eFormRecord;
  }),
  TypedReducer<EFormRecord,ReloadFormRecordEditAction>((EFormRecord eFormRecord,ReloadFormRecordEditAction action){
    eFormRecord = action.record;
    return eFormRecord;
  }),

]);



