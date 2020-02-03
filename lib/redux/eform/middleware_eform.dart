import 'dart:async';
import 'state_eform.dart';

import 'package:redux/redux.dart';

import 'package:http/http.dart' as http;

import 'package:sitediary/datas/user.dart';
import 'package:sitediary/datas/http_handler.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:sitediary/datas/eform.dart';

class MiddleWareEForm{

  List<Middleware<EFormState>> createStoreMiddlewareEForm() {
    return [
      //LoggingMiddleware<EFormState>.printer(),
      TypedMiddleware<EFormState, GetEFormListServerActon>(_getListOnServer),
    ];
  }
  Future _getListOnServer(Store<EFormState> store, GetEFormListServerActon action, NextDispatcher next) async {
    ResponseItem ri;
    try {

      User u = action.appState.user;
      RequestHandler rh = RequestHandler.fromListItemRequest(u, action.requestTypeInt, action.offset, action.offsetCount);

      //store.state.isProcessingHttp = true;
      http.post(action.appState.serverUrlBase, body: rh.toJsonString()).then((response){
        final responseBody = response.body;
        // The response body is an array of items
        ri = ResponseItem.fromJsonString(responseBody);
        ri.eformList = List<EForm>()..add(EForm());

        action.completer.complete(ri.eformList??List<EForm>()..add(EForm()));
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

}

