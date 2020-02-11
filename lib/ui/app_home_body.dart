
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:package_info/package_info.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/router.dart';
import 'package:sitediary/ui/sitediary/site_diary_main.dart';
import 'google_map.dart';
import 'list/form_category.dart';
import 'loading.dart';
import 'package:sitediary/datas/user.dart';

class AppHomeBody extends StatefulWidget {

  final Function showLoginFunction;
  final User user;

  AppHomeBody(this.showLoginFunction, this.user );

  @override
  _AppHomeBodyState createState() => _AppHomeBodyState();
}

class _AppHomeBodyState extends State<AppHomeBody> with AutomaticKeepAliveClientMixin {
  _showMessage( BuildContext context, String text){
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildBody1(context);
  }

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {

      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      setState(() {
        versionLabel ='$version + $buildNumber';
      });
    });
  }

  String versionLabel='';

  Widget _showMap(){
    return RaisedButton(
      child: Text("Map"), onPressed: () {
      Navigator.pushNamed(context, GoogleMapViewerApp.routeName).then((v){
        if (v==null) return;
        _showMessage(context, '$v');
      });
    },);
  }

  List<Widget> createButtonList(){

    List<Router> actionList = [];
    actionList.add(FormCategoryList.router);
    actionList.add(SiteDiaryMain.router);

    List<Widget> list = [];

    actionList.forEach((Router t){
      list.add(
        RaisedButton(
          child: Text(t.buttonText), onPressed: () {

          final store = StoreProvider.of<SiteDiaryState>(context);
          final state = store.state;
          final worker = state.currentSiteDiaryWorker;
          setState(() {
            worker.lastReloadDataDate = null;
          });

          if ((widget.user.loginName ?? '') == '')
            widget.showLoginFunction(context, true);
          else
            Navigator.pushNamed(context, t.routeName);
        },
        )
      );
    });

    bool showMap = false;
    list.add(Container(height: 30,));
    list.add(showMap?_showMap():Container());

    return list;
  }

  Widget _buildBody1(BuildContext context) {

    if (widget.user.isNeedShowLoginScreen) {
      widget.showLoginFunction(context, false);
      return LoadingApp();
    }

    return Column(
      mainAxisAlignment:  MainAxisAlignment.start,
      children: <Widget>[

        Container(
          child: Text('Welcome, ${widget.user.loginName} !'),
          padding: EdgeInsets.all(8),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: createButtonList()
              ),
            ),
          ),
        ),
        Container(
          child: Text('App version: $versionLabel '),
          padding: EdgeInsets.only(bottom: 10),
        ),

      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
