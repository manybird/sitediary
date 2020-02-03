
import 'package:redux/redux.dart';
import 'state_app.dart';

import 'actions.dart';
import 'package:sitediary/datas/user.dart';
import 'eform_action.dart';


AppState appReducer(AppState state, action) {
  return AppState(
    _serverIPReducer(state.serverIP, action),
    _listLoadedStateReducer(state.isNeedLoadSettingFile,action),
    _httpStateReducer(state.isProcessingHttp,action),
    _userReducer(state.user,action),
  );
}




final Reducer<String> _serverIPReducer = combineReducers<String>([
  TypedReducer<String, ChangeServerIpAction>(_changeServerIP),
]);

String _changeServerIP(String serverIP, ChangeServerIpAction action) => action.serverIP;

final Reducer<bool> _listLoadedStateReducer = combineReducers<bool>([
  TypedReducer<bool, LoadListAction>((bool listState, LoadListAction action) => false),
]);

final Reducer<bool> _httpStateReducer = combineReducers<bool>([
  TypedReducer<bool, HttpAction>((bool isProcessing, HttpAction action) => action.isProcessing),
]);

final Reducer<User> _userReducer = combineReducers<User>([
  TypedReducer<User, LoginAction>((User u, LoginAction action) => action.doIt(u)),
  TypedReducer<User, LoginScreenShowToUserAction>((User u, LoginScreenShowToUserAction action) => action.doIt(u)),
  TypedReducer<User, ShowFormRecordListAction>((User u, ShowFormRecordListAction action) => u..selectedEFormKey = action.eFormKey),
  TypedReducer<User, ChangeUserSelectedSectionAction>((User u, ChangeUserSelectedSectionAction action) => u..userSelectedSection = action.userSelectedSection),
  TypedReducer<User, UserDoSearchAction>((User u, UserDoSearchAction action) {
    return u..userSearchOption = action.userSearchOption;
  }),
]);







