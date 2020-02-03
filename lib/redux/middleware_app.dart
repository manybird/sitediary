import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';


import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:sitediary/persistence/file_store.dart';
import 'package:http/http.dart' as http;

import 'actions.dart';
import 'state_app.dart';
import 'package:sitediary/datas/user.dart';
import 'package:sitediary/datas/http_handler.dart';
import 'package:sitediary/redux/eform_action.dart';


class MiddleWareApp{

  List<Middleware<AppState>> createStoreMiddlewareApp() {
    return [
      LoggingMiddleware<AppState>.printer(),
      TypedMiddleware<AppState, SaveListAction>(_saveStateToFile),
      TypedMiddleware<AppState, LoadListAction>(_loadStateFromFile),
      TypedMiddleware<AppState, CheckLoginOnServerAction>(_checkLoginOnServer),

    ];
  }


  
  Future _checkLoginOnServer(Store<AppState> store, CheckLoginOnServerAction action, NextDispatcher next) async {
    ResponseItem ri;
    try {

      User u = store.state.user;

      final uLogin = User();

      uLogin.loginName = action.loginName;
      uLogin.fcmToken = action.fcmToken;
      uLogin.hashPassword = md5.convert(utf8.encode(action.password)).toString();
      RequestHandler rh = RequestHandler.fromUser(uLogin, action.requestTypeInt);

      store.state.isProcessingHttp = true;
      http.post(store.state.serverUrlBase, body: json.encode(rh)).then((response){
        final responseBody = response.body;
        // The response body is an array of items
        print('_checkLoginOnServer, responseBody: $responseBody');
        ri = ResponseItem.fromJsonString(responseBody);

        u.isLoginSuccess = ri.isSuccess;
        if (ri.isSuccess && ri.loginUser!=null) {
          u.loginName = ri.loginUser.loginName;
          u.fcmToken = action.fcmToken;
          u.isDoingLogin = false;
          u.company = ri.loginUser.company; //Get company from server.
          _saveSetting(store);
          u.hashPassword = '';
          action.completer.complete(ri);
        }
        else{
          u.hashPassword = '';
          action.completer.completeError('Error on login!');
        }

      }).catchError((error){
        action.completer.completeError(error);
      }).whenComplete((){
        //Action when completed
        //store.state.isProcessingHttp = false;
      });

    } catch (e) {
      action.completer.completeError(e);
    }
    next(action);
  }

  Future _saveStateToFile(Store<AppState> store, SaveListAction action, NextDispatcher next) async {
    //await Future.sync(() => Duration(seconds: 3)); // Simulate saving the list to disk
    _saveSetting(store);
    next(action);
  }

  void _saveSetting(Store<AppState> store){
    final s = json.encode(store.state);
    final c = FileStorage(AppState.settingFIle, true);
    c.writeString(s);
  }

  Future _loadStateFromFile(Store<AppState> store, LoadListAction action, NextDispatcher next) async {

    try {
      //await Future.delayed(Duration(seconds: 10));

      final c = FileStorage(AppState.settingFIle, true);
      String s = await c.readString();
      if (s==null || s.isEmpty){
        //store.state.user.isLoginSuccess = false;
        store.state.user.loginName = '';
        store.state.user.hashPassword='';
        return;
      }
      dynamic js = json.decode(s);
      final state = AppState.fromJson(js);
     // state.user.isLoginSuccess = false;
      store.state.cloneFromLoadFile(state);

    } catch (e) {
      print(e);
    }

    next(action);
  }
}

