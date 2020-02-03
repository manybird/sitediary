

import 'dart:io';

import 'package:sitediary/datas/fc_message.dart';
import 'package:sitediary/persistence/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:sitediary/datas/user.dart';
import 'package:sitediary/datas/http_handler.dart';
import 'package:sitediary/redux/actions.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'setting.dart';

class LoginScreen extends StatefulWidget {

  static String routeName = '/login';

  final Function loginSuccessCallBack;

  LoginScreen(this.loginSuccessCallBack);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  FirebaseMessaging _fireBaseMessaging = FirebaseMessaging();
  String fcmToken ="";

  _showMessage( String text){
    if (messageContext==null) return;
    Scaffold.of(messageContext)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  BuildContext messageContext;
  void onLoginSubmit(_ViewModel viewModel, Store<AppState> store)  {

    String lastFcmTopicName = store.state.user.fcmTopicName;

    String loginName = viewModel.textEditingController.text;
    String p = viewModel.textEditingControllerPassword.text;

    if (loginName.isEmpty || p.isEmpty) {
      _showMessage('Provide username and password');
      return;
    }

    final action1 = CheckLoginOnServerAction(loginName, p, fcmToken, store.state);
    store.dispatch(action1);

    ///action call back here, support multiple actions
    ///
    Future.wait([action1.completer.future]).then((List<dynamic> list){
      list.forEach((f){
        ResponseItem ri = f;
        //print('action1.completer: $ri');
        if (ri.isSuccess) {
          final user = ri.loginUser;
          final loginNameFcmTopic = user.fcmTopicName;
          print('fcmToken != store.state.user.fcmToken: ${fcmToken != store.state.user.fcmToken}');

          if((lastFcmTopicName??'').isNotEmpty && lastFcmTopicName!=loginNameFcmTopic){
            print('Login change from <$lastFcmTopicName> to <$loginNameFcmTopic> ! Do unsubscribeFromTopic in FCM for <$lastFcmTopicName>');
            _fireBaseMessaging.unsubscribeFromTopic(lastFcmTopicName);
          }

          _fireBaseMessaging.subscribeToTopic(loginNameFcmTopic);
          if (fcmToken != store.state.user.fcmToken && fcmToken.isNotEmpty){
          }

          final n = LocalNotification();
          n.requestNotificationPermissionsIfNeed(messageContext);

          n.createNotification(FcNotification()..title = 'Login success!'..body='${user.company}  ${user.loginName}');

          //final topic =  loginName;
          //print(topic);
          //_fireBaseMessaging.subscribeToTopic(topic );
          widget.loginSuccessCallBack();
          Navigator.pop(context);
        } else {
          print(ri.message);
          this._showMessage(ri.message);
        }
      });
      //store.dispatch(HttpAction(false));
    }).catchError((error){
      print('checkLoginOnServerActionCallback: $error');
      this._showMessage( '$error');
      //store.dispatch(HttpAction(false));
    }).whenComplete((){
      //viewModel.textEditingControllerPassword.text = '';
      store.dispatch(HttpAction(false));
    });

  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS && false) {
      _fireBaseMessaging.requestNotificationPermissions(
          IosNotificationSettings(sound:
          true, badge: true, alert: true)
      );

      _fireBaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
    }
    _fireBaseMessaging.getToken().then((token){
      fcmToken = token;
      print('firebase token: $token !');
    });


  }



  @override
  Widget build(BuildContext context) {
    return  _buildAppLoginHome(context);
  }

  Widget _buildAppLoginHome(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: _buildColumns()
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.settings),
          onPressed: (){
            Navigator.of(context).pushNamed(SettingScreen.routeName);
          },
        ),
      )
    );
  }



  Widget _buildColumns() {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (Store<AppState> store) {
          print('login  - onInit: User: ${store.state.user}');
          if (store.state.isNeedLoadSettingFile) {
            store.dispatch(LoadListAction());
          }
        },
        converter: (Store<AppState> store) {
          print('login - converter: User: ${store.state.user}');

          return _ViewModel( loginCallback: onLoginSubmit).._buildWidget(store);
        },
        onWillChange: (_ViewModel viewModel){
          //print('login - onWillChange: viewModel: $viewModel');
        },
        builder: (BuildContext ctx, _ViewModel viewModel) {
          print('login  - builder: viewModel: $viewModel');
          messageContext = ctx;
          return viewModel.showView(ctx);

        }
    );
  }
}

class _ViewModel{
  FocusNode _theFocusNode;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNodePass= FocusNode();
  Widget widget;
  final Function loginCallback;


  _ViewModel({
    Key key,
    this.loginCallback,
  });

  Widget showView(BuildContext ctx){
    if (_theFocusNode!=null){
      FocusScope.of(ctx).requestFocus(_theFocusNode);
      _theFocusNode = null;
    }
    return widget;
  }

  void _buildWidget(Store<AppState> store){

    User u = store.state.user;
    textEditingController.text = u.loginName;

    if (!store.state.isNeedLoadSettingFile){
      if (u.hasLoginName) {
        _theFocusNode = focusNodePass;
      } else {
        _theFocusNode = focusNode;
      }
    }

    this.widget = Builder(builder: (BuildContext ctx) {
      return Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('e-Form', style: Theme
              .of(ctx)
              .textTheme
              .display1),
          SizedBox(height: 18),
          _LoginTextField(hintText: 'Login',
            textEditingController: textEditingController,
            focusNode: focusNode,
            //autoFocus: !store.state.user.hasLoginName,
          ),
          SizedBox(height: 12),
          _LoginTextField(hintText: 'Password',
            obscureText: true,
            textEditingController: textEditingControllerPassword,
            focusNode: focusNodePass,
            //autoFocus: store.state.user.hasLoginName,
          ),
          SizedBox(height: 24),
          FlatButton( // Here we call the method above. We need to provide
            // the model.
            onPressed: store.state.isProcessingHttp ? null : () =>
                this.loginCallback(this, store),
            // onLoginSubmit(ctx, store),
            color: store.state.isProcessingHttp ? Colors.grey : Colors.yellow,
            child: Text(
                store.state.isProcessingHttp ? 'Process...' : 'Login'),),
        ],);
    }
    );


  }


}

/// Convenience widget for the login text fields.
class _LoginTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController textEditingController;
  final bool autoFocus;
  final FocusNode focusNode;

  _LoginTextField({
    Key key,
    @required this.hintText,
    this.obscureText = false,
    this.textEditingController,
    this.autoFocus,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(
      //autofocus: autoFocus,
      focusNode: focusNode,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.black12,
      ),
      obscureText: obscureText,
    );
  }
}