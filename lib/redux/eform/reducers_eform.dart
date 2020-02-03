
import 'state_eform.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:redux/redux.dart';
import 'package:sitediary/datas/eform.dart';

EFormState eFormReducer(EFormState state, action) {
  return EFormState(
    _eFormReducer(state.currentEForm,action),
    //_eFormRecordReducer(state.currentEFormRecord,action),
  );
}

final Reducer<EForm> _eFormReducer = combineReducers<EForm>([
  TypedReducer<EForm,ChangeCurrentEFormAction>((EForm eForm,ChangeCurrentEFormAction action){
    eForm = action.eform;
    action.completer.complete();
    return eForm;
  }),
]);





