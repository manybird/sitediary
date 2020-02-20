import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/datas/sitediary/sitediary_list_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/ui/sitediary/editor/checkbox_editor.dart';
import 'package:sitediary/ui/sitediary/editor/combo_editor.dart';
import 'package:sitediary/ui/sitediary/editor/text_editor.dart';

class SiteDiaryLocationEdit extends StatefulWidget {

  final SDLocationRecord record;
  SiteDiaryLocationEdit(this.record);

  @override
  _SiteDiaryLocationEditState createState() => _SiteDiaryLocationEditState();
}

class _SiteDiaryLocationEditState extends State<SiteDiaryLocationEdit> with AutomaticKeepAliveClientMixin {
  SiteDiaryWorker worker;

  ComboItemFactory _createSubContractorCombo(SDLocationRecord r ){
    final f = ComboItemFactory.init();

    f.buildDropDownMenuItems(
      worker.subContractorList , r.SubContractor,
      dummyItemIfEmpty: SDSubContractorList(),
    );

    f.onSelectionChanged = (v){
      setState(() {
        r.SubContractor = '$v';
      });
    };
    return f;
  }
  ComboItemFactory _createAreaCombo(SDLocationRecord r ){
    final f = ComboItemFactory.init( );
    worker.areaListAdd(r.Area, r.WorkOrderNO);
    f.buildDropDownMenuItems(
      worker.areaList, r.Area,
    );
    //if (r.Area==null && f.initItem!=null) r.Area = '${f.initItem.value}';

    f.onSelectionChanged = (v){
      setState(() {
        r.resetArea(v.toString());
      });
    };
    return f;
  }
  ComboItemFactory _createLocCombo(SDLocationRecord r ){
    //print('_createLocCombo: $r');
    final f = ComboItemFactory.init( );
    f.onComboEditAdd = (result){
        worker.locListAdd(r.Area, result);
    };
    worker.locListAdd(r.Area, r.Location);
    f.buildDropDownMenuItems(
      worker.locListByArea(r.Area) , r.Location,
      dummyItemIfEmpty: SDLocList(),
    );
    if (r.Location==null && f.selectedItem!=null){
      if (f.selectedItem.value==null){
        r.Location = '';
      }else {
        r.Location = f.selectedItem.value.toString();
      }
    }

    f.onSelectionChanged = (v){
      setState(() {
        r.resetLocation(v.toString());
      });
    };
    return f;
  }
  ComboItemFactory _createWOCombo(SDLocationRecord r ){
    final f = ComboItemFactory.init( );
    f.onComboEditAdd = (result){
      worker.woListAdd(r.Area, result);
    };
    worker.woListAdd(r.Area, r.WorkOrderNO);
    f.buildDropDownMenuItems(
        worker.woListByArea(r.Area) , r.WorkOrderNO,
        dummyItemIfEmpty: SDWOList.fromEmpty(),
    );
    if (r.WorkOrderNO==null && f.selectedItem!=null){
      if (f.selectedItem.value==null){
        r.WorkOrderNO = '';
      }else{
        r.WorkOrderNO = f.selectedItem.value.toString();
      }

    }

    f.onSelectionChanged = (v)=> setState(() {
      return r.WorkOrderNO = '$v';
    });
    return f;
  }
  ComboItemFactory _createStreet1Combo(SDLocationRecord r ){
    final f = ComboItemFactory.init();
    worker.streetListAdd(r.Area, r.Location,r.Street1);
    f.buildDropDownMenuItems(
      worker.streetListBy(r.Area,r.Location) ,
      r.Street1,
      dummyItemIfEmpty: SDStreetList(),
    );
    //if (r.Street1==null && f.initItem!=null)     r.Street1 = '${f.initItem.value}';

    f.onSelectionChanged = (v)=> setState(() {
      r.resetStreet1(v.toString());
    });
    return f;
  }
  ComboItemFactory _createStreet2Combo(SDLocationRecord r ){
    final f = ComboItemFactory.init( );
    worker.streetListAdd(r.Area, r.Location,r.Street2);
    f.buildDropDownMenuItems(
      worker.streetListBy(r.Area,r.Location) , r.Street2,
      dummyItemIfEmpty: SDStreetList(),
    );
    f.onSelectionChanged = (v)=> setState(() => r.Street2 = '$v');
    return f;
  }
  ComboItemFactory _createStreet3Combo(SDLocationRecord r ){
    final f = ComboItemFactory.init( );
    final v = r.Street3;
    worker.streetListAdd(r.Area, r.Location,v);
    f.buildDropDownMenuItems(
      worker.streetListBy(r.Area,r.Location) , v,
      dummyItemIfEmpty: SDStreetList(),
    );
    f.onSelectionChanged = (v)=> setState(() => r.Street3 = '$v');
    return f;
  }
  ComboItemFactory _createStreet4Combo(SDLocationRecord r ){
    final f = ComboItemFactory.init( );
    final v = r.Street4;
    worker.streetListAdd(r.Area, r.Location,v);
    f.buildDropDownMenuItems(
      worker.streetListBy(r.Area,r.Location) , v,
      dummyItemIfEmpty: SDStreetList(),
    );
    f.onSelectionChanged = (v)=> setState(() => r.Street4 = '$v');
    return f;
  }
  ComboItemFactory _createReserve1Combo(SDLocationRecord r ){
    final f = ComboItemFactory.init( );
    final v = r.Reserve1;
    worker.reserve1ListAdd(r.Area, r.Location,r.Street1,v);
    f.buildDropDownMenuItems(
      worker.reserve1ListBy(r.Area,r.Location,r.Street1) ,
      v,
      dummyItemIfEmpty: SDLocReserve1List(),
    );
    f.onSelectionChanged = (v)=> setState(() {
      r.resetReserve1(v.toString());
    });
    return f;
  }
  ComboItemFactory _createReserve2Combo(SDLocationRecord r ){
    final f = ComboItemFactory.init();
    final v = r.Reserve2;
    worker.reserve2ListAdd(r.Area, r.Location,r.Street1,r.Reserve1,v);
    f.buildDropDownMenuItems(
      worker.reserve2ListBy(r.Area,r.Location,r.Street1,r.Reserve1) ,
      v,
      dummyItemIfEmpty: SDLocReserve2List(),
    );
    f.onSelectionChanged = (v)=> setState(() {
      r.Reserve2 = v.toString();
    });
    return f;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final  store = StoreProvider.of<SiteDiaryState>(context);
    worker = store.state.currentSiteDiaryWorker;
    final r = widget.record;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ComboEditor(_createSubContractorCombo(r),title: 'Sub Contractor'),
                ComboEditor(_createAreaCombo(r),title: 'Area',),
                ComboEditor(_createLocCombo(r),title: 'Location',),
                ComboEditor(_createWOCombo(r),title: 'WO',),
                ComboEditor(_createStreet1Combo(r),title:  'Street1',),
                ComboEditor(_createStreet2Combo(r),title:  'Street2',),
                ComboEditor(_createStreet3Combo(r),title:  'Street3',),
                ComboEditor(_createStreet4Combo(r),title:  'Street4',),
                ComboEditor(_createReserve1Combo(r),title: 'Reserve1',),
                ComboEditor(_createReserve2Combo(r),title: 'Reserve2',),
                TextEditor(
                  r.TeamPrefix,
                  title: 'Team Prefix',
                  onTextChanged: (v){
                    setState(() => r.TeamPrefix = v);
                  },
                ),
                TextEditor(
                  r.Section,
                  title: 'Section',
                  maxLine: 3,
                  onTextChanged: (v){
                    setState(() => r.Section = v);
                  },
                ),
                CheckBoxEditor(
                  r.Updated,
                  title: 'Updated',
                  onCheckedChanged: (checked){
                    setState(() => r.Updated = checked);
                  },
                )
              ],
          ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
