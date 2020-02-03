
import 'package:sitediary/ui/setting.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'app_home_body.dart';
import 'login.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


import 'package:sitediary/redux/eform_action.dart';

import 'package:sitediary/datas/fc_message.dart';
import 'package:sitediary/persistence/local_notification.dart';

class AppHome extends StatefulWidget {

  static final routeName ='/app_home';
  final String title='Home';
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with AutomaticKeepAliveClientMixin {
  FirebaseMessaging _fireBaseMessaging = FirebaseMessaging();

  int _currentIndex = 0;
  String fcMessage;

  _showMessage( BuildContext context, String text){
    if(!this.mounted) return;
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void loginSuccessCallback(){
    //Store<AppState>  store = StoreProvider.of(context);
    //store.state.user.isLoginSuccess = true;
    //store.state.user.isDoingLogin = false;
    //store.dispatch(Login)
  }

  void _showLoginScreen(BuildContext context,  bool isLogout){
    Store<AppState>  store = StoreProvider.of(context);
    if (!isLogout && !store.state.user.isNeedShowLoginScreen) return;
    print('app_home - _showLoginScreen - isLogout: $isLogout');
    @override
    void run() {
      store.dispatch(LoginScreenShowToUserAction());
      scheduleMicrotask(() {
        //Navigator.pushNamed(ctx, LoginScreen.routeName);

        //isLoginSuccess = false;
        //isDoingLogin = true;

        Navigator.push(context,MaterialPageRoute(builder: (c){
          return LoginScreen(loginSuccessCallback);
        }));

      });
    }
    run();
  }

  Future<bool> _dialogShowLogoutApp(BuildContext context) {

    return showDialog(context: context, builder: (c) {
      return  AlertDialog(content:  Text("Logout?"),
      actions: <Widget>[
         FlatButton(
          onPressed: () => Navigator.of(c).pop(false),
          child:  Text("NO"),),

          FlatButton(onPressed: () {

            Navigator.of(c).pop(false);
            _showLoginScreen(c, true);
          },
          child:  Text("YES"),
          ),
      ],);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    print('app home initstate.');
    _fireBaseMessaging.configure(
      onMessage: (e) async {
        final mm = FcMessage.fromHashMap(e);

        final n = LocalNotification();
        n.createNotification(mm.notification);

        fcMessage = 'onMessage: $e';
        print(fcMessage);

        _showMessage(context, fcMessage);
      },
      onLaunch: (e) async {
          fcMessage = 'onLaunch: $e';
          print(fcMessage);
          _showMessage(context, fcMessage);

        },
      onResume: (e) async
      {
        fcMessage = 'onLaunch: $e';
        print(fcMessage);
        _showMessage(context, fcMessage);

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildAppHome(context);
  }

  Widget _buildAppHome(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        return _dialogShowLogoutApp(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _dialogShowLogoutApp(context);
              }, // _showCounterOnPageRoute
            )
          ],
        ),
        body:_buildBody(context),
        //floatingActionButton: FloatingActionButton( onPressed: _incrementCounter,  child: Icon(Icons.add), ),
        bottomNavigationBar: _createNavigationBar(),
        drawer: _createDrawer(),
      ),
    );
  }

  Widget _createDrawer() {
    return Builder(builder: (BuildContext context){
      return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
              padding: EdgeInsets.all(1),
              children: <Widget>[
                Container(
                  //height: 100,
                  margin: EdgeInsets.only(bottom: 0),
                  padding: EdgeInsets.all(0.0),
                  child:  DrawerHeader(
                    child: Row(children: <Widget>[
                      Text('Options',style: TextStyle(fontSize: 28.0),),
                      //Icon(Icons.slideshow),
                    ],
                    ) ,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.arrow_back),
                  title: Text('Logout'),
                  onTap: () {
                    // Then close the drawer
                    Navigator.pop(context);
                    _dialogShowLogoutApp(context).then((b){
                      if (b){ }
                    });

                  },
                ),

              ]
          )
      );

    });


  }

  BottomNavigationBarItem _createNavigationBarItem(IconData i,String text) {
    return BottomNavigationBarItem(
      icon: Icon(i, color: Colors.blue,),
      title: Text(text, style: TextStyle(color: Colors.blueGrey),),
    );
  }

  BottomNavigationBar _createNavigationBar() {
    return BottomNavigationBar(
      items: [
        _createNavigationBarItem(Icons.home,'HOME'),
        _createNavigationBarItem(Icons.settings,'Setting'),
        _createNavigationBarItem(Icons.tab,'PageWise'),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: _currentIndex,
      onTap: _onPageChange,

    );
  }

  void _onPageChange(index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }
  var _pageController = PageController(
    initialPage: 0,
  );
  Widget _buildBody(BuildContext context) {
    Store<AppState>  store = StoreProvider.of<AppState>(context);

    return PageView(
        //physics: NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChange,
        controller: _pageController,
        children: <Widget>[
          AppHomeBody(_showLoginScreen,store.state.user),
          //_buildBody2(),
          SettingScreen(false),
          _buildBody3(),
        ]
    );
  }

  Widget _buildBody3(){
    return Container();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

