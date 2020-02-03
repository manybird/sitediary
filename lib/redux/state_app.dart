

import 'package:sitediary/datas/user.dart';
import 'package:json_annotation/json_annotation.dart';


part 'state_app.g.dart';

@JsonSerializable()
class AppState {

  static String serverIpDefault = '192.168.10.98';

  User user;

  static String settingFIle = 'settings.json';
  bool isNeedLoadSettingFile= true;
  bool isProcessingHttp = false;

  String serverUrlPrefix = 'http://';
  String serverUrlSub = '/sitediary/api.ashx';
  String serverIP = '192.168.10.98';

  String get serverUrlBase {
    return serverUrlPrefix + serverIP + serverUrlSub;
  }

  AppState(
       this.serverIP
      ,this.isNeedLoadSettingFile,this.isProcessingHttp
      , this.user
      );

  factory AppState.initial(){
    return AppState(
         serverIpDefault,true
        ,false
        ,User()..userSearchOption = UserSearchOption()
    );
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    final s = _$AppStateFromJson(json);
    if (s.user.userSearchOption==null) s.user.userSearchOption = UserSearchOption();
    return s;
  }

  void cloneFromLoadFile(AppState state){
    isNeedLoadSettingFile = false;
    user.loginName = state.user.loginName;
    user.company = state.user.company;
    user.userSearchOption = state.user.userSearchOption;
    if (user.userSearchOption==null) user.userSearchOption = UserSearchOption();
    serverIP = state.serverIP;
  }

  dynamic toJson()=> _$AppStateToJson (this);

  @override
  String toString() {
    return 'User: ${this.user}';
  }

}
