import 'package:sitediary/datas/eform_item_section.dart';
import 'package:sitediary/datas/user.dart';
import 'dart:async';

import 'package:sitediary/datas/eform.dart';
import 'package:sitediary/datas/eform_record.dart';
import 'package:sitediary/persistence/file_store.dart';

import 'state_app.dart';

abstract class UserAction{
  User doIt(User u);
}

class LoginAction extends UserAction {
  final String loginName;
  final bool isLogout;
  LoginAction(this.loginName, this.isLogout);

  @override
  User doIt(User u){
    if (this.isLogout){
      u.isLoginSuccess = false;
      u.isDoingLogin = false;
    }else{
      u.isLoginSuccess = true;
      u.isDoingLogin = false;
      u.loginName = this.loginName;
    }
    return u;
  }
}

class LoginScreenShowToUserAction extends UserAction{
  LoginScreenShowToUserAction();

  @override
  User doIt(User u){
    u.isLoginSuccess = false;
    u.isDoingLogin = true;
    return u;
  }
}

abstract class ServerAction{

  Completer completer = Completer();
  int requestTypeInt;
  final AppState appState;

  ServerAction(this.appState);
}

class GetEFormListServerActon extends ServerAction{
  final int offset;
  final int offsetCount;
  @override
  int requestTypeInt = 2;

  GetEFormListServerActon(this.offset,this.offsetCount, AppState appState):super(appState);
}

class CheckLoginOnServerAction extends ServerAction {
  final String loginName;
  final String password;
  final String fcmToken;

  @override
  int requestTypeInt = 1;

  CheckLoginOnServerAction(this.loginName, this.password,this.fcmToken, AppState appState):super(appState);
}


class ShowFormRecordListAction{
  final String eFormKey;
  ShowFormRecordListAction(this.eFormKey);
}

class ChangeCurrentEFormAction{
  final EForm eform;
  Completer completer = Completer();
  ChangeCurrentEFormAction(this.eform);
}

class CreateNewRecordServerAction extends ServerAction{
  final String eFormKey;

  @override
  final int requestTypeInt = 10;

  CreateNewRecordServerAction(this.eFormKey, AppState appState):super(appState);
}

class GetFormRecordByRecordIdAction extends ServerAction{
  @override
  final int requestTypeInt = 4;
  final String eFormRecordId;
  final String eFormKey;
  GetFormRecordByRecordIdAction( this.eFormKey, this.eFormRecordId, AppState appState):super(appState);
}

class SaveFormItemServerAction extends ServerAction{
  @override
  final int requestTypeInt = 11;

  /// If false, save only

  final EFormItemSectionAction action;
  SaveFormItemServerAction(this.action, AppState appState):super(appState);
}

class UpdateFormItemDetailAction {
  final  EFormRecordDetail recordDetail;
  UpdateFormItemDetailAction(this.recordDetail);
}

class ReloadFormRecordEditAction {
  final  EFormRecord record;
  ReloadFormRecordEditAction(this.record);
}

class DownloadFileServerAction extends ServerAction{

  final Function onReceiveProgress;
  final FileCopier fileCopier;
  DownloadFileServerAction(this.onReceiveProgress, this.fileCopier, AppState appState) : super(appState);
}

//User report
class DownloadReportServerAction extends ServerAction{
  final EFormRecord eFormRecord;
  final Function onReceiveProgress;
  DownloadReportServerAction(this.eFormRecord, this.onReceiveProgress, AppState appState) : super(appState);
}

