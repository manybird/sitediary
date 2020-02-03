
import 'package:sitediary/datas/eform_item_section.dart';

import 'package:sitediary/persistence/location_camera.dart';
import 'package:sitediary/ui/template/edit_dialog.dart';
import 'package:flutter/material.dart';

import '../google_map.dart';


class EFormMapItemWidget extends StatefulWidget {

  final EFormItemSectionDetail sectionDetail ;
  final bool canEdit;

  EFormMapItemWidget(this.sectionDetail,this.canEdit);

  @override
  _EFormMapItemWidgetState createState() => _EFormMapItemWidgetState();
}

class _EFormMapItemWidgetState extends State<EFormMapItemWidget> {

  void _showMapSelection( BuildContext context){

    final page = MaterialPageRoute(builder: (c){

      final r = widget.sectionDetail.recordDetail;

      final lc = LocationCamera.fromString(
          r.itemThumbPath
      );
      lc.featureName = r.itemValue;

      return GoogleMapViewerApp(lc, recordDetail: r,);
    });

    Navigator.push(context,page).then((v){
      if (v==null) return;
    });
  }

  Widget _getMapWidgetButton( BuildContext context) {
    final r = widget.sectionDetail.recordDetail;


    double width = MediaQuery .of(context) .size .width - 100;
    final itemWidgetList = List<Widget>();

    itemWidgetList.add( Text( '${r.itemValue??''}') );

    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: !widget.canEdit?null: (){
              _showMapSelection(context);
            },
          ),
          GestureDetector(
            child: Container(
              width: width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: itemWidgetList,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))
              ),
            ),
            onTap: !widget.canEdit?null: (){
              //_showMapSelection(context);
              showDialog(context: context, builder: (c) {
                return RecordDetailEditingDialog(r);
              });
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return _getMapWidgetButton(context);
  }
}