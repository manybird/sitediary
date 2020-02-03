

import 'package:flutter/material.dart';

import 'package:sitediary/redux/state_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:sitediary/redux/actions.dart';


class SettingScreen extends StatefulWidget {

  static String routeName = '/setting';
  SettingScreen(this.isShowAppBar);

  factory SettingScreen.noAppBar(){
    return SettingScreen(false);
  }

  final bool isShowAppBar;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  _showMessage( String text){
    if (messageContext==null) return;
    Scaffold.of(messageContext)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  BuildContext messageContext;
  void onSubmit(_ViewModel viewModel, Store<AppState> store)  {

    String ip = viewModel.textEditingController.text;
    if (ip.isEmpty) {
      _showMessage('Provide IP ');
      return;
    }
    final action1 = ChangeServerIpAction(ip);
    store.dispatch(action1);
    if(widget.isShowAppBar) Navigator.pop(messageContext);
    else _showMessage('Saved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: _buildColumns()
        ),
      ),
      appBar: widget.isShowAppBar?AppBar(title: Text('Setting'), ):null,
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

          return _ViewModel( onSubmit).._buildWidget(store,widget.isShowAppBar);
        },
        onWillChange: (_ViewModel viewModel){
          //print('login - onWillChange: viewModel: $viewModel');
        },
        builder: (BuildContext context, _ViewModel viewModel) {
          print('login  - builder: viewModel: $viewModel');
          messageContext = context;
          return viewModel.showView(context);

        }
    );
  }
}

class _ViewModel{
  FocusNode _theFocusNode;

  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Widget widget;
  final Function loginCallback;

  _ViewModel(
    this.loginCallback,
  );

  Widget showView(BuildContext ctx){
    if (_theFocusNode!=null){
      FocusScope.of(ctx).requestFocus(_theFocusNode);
      _theFocusNode = null;
    }
    return widget;
  }

  void _buildWidget(Store<AppState> store, bool isShowAppBar){


    textEditingController.text = store.state.serverIP;
    if (isShowAppBar) _theFocusNode = focusNode;

    this.widget = Builder(builder: (BuildContext ctx) {
      return Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LoginTextField(hintText: 'Server IP',
            textEditingController: textEditingController,
            focusNode: focusNode,
            //autoFocus: !store.state.user.hasLoginName,
          ),
          FlatButton( // Here we call the method above. We need to provide
            // the model.
            onPressed: () =>
                this.loginCallback(this, store),
            // onLoginSubmit(ctx, store),
            color:  Colors.yellow,
            child: Text( 'Save')
          ),
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