import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/datas/sitediary/sitediary_list_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/ui/sitediary/combo_item.dart';

class SiteDiaryLocationEdit extends StatefulWidget {

  final SDLocationRecord record;
  SiteDiaryLocationEdit(this.record);

  @override
  _SiteDiaryLocationEditState createState() => _SiteDiaryLocationEditState();
}

class _SiteDiaryLocationEditState extends State<SiteDiaryLocationEdit> with AutomaticKeepAliveClientMixin {
  SiteDiaryWorker worker;

  ComboItemFactory _createSubContractorCombo(SDLocationRecord r ){
    final f = ComboItemFactory.init( 'Sub Contractor');

    for(final c in worker.subContractorList){
      final ddi = DropdownMenuItem(
        value: c,
        child: ComboDropDownItemChild(
          f, c,
          '$c' == r.SubContractor || (f.initItem==null && r.SubContractor ==null),
        ),
      );

      if (f.initItem == null) {
        f.initItem = ddi;
      }else if ('$c' == r.SubContractor){
        f.initItem = ddi;
      }
      f.dropdownMenuItems.add(ddi);
    }

    if (r.SubContractor==null && f.initItem!=null)
      r.SubContractor = '${f.initItem.value}';

    f.onSelectionChanged = (v){
      setState(() {
        r.SubContractor = '$v';
      });
    };
    return f;
  }

  ComboItemFactory _createAreaCombo(SDLocationRecord r ){
    final f = ComboItemFactory.init( 'Area');

    for(final c in worker.areaList){
      final ddi = DropdownMenuItem(
        value: c,
        child: ComboDropDownItemChild(
         f, c,
          '$c' == r.Area || (f.initItem==null && r.Area ==null),
        ),
      );

      if (f.initItem == null) {
        f.initItem = ddi;
      }else if ('$c' == r.Area){
        f.initItem = ddi;
      }
      f.dropdownMenuItems.add(ddi);
    }

    if (r.Area==null && f.initItem!=null)
      r.Area = '${f.initItem.value}';

    f.onSelectionChanged = (v){
      setState(() {
        r.Area = '$v';
        r.Location = null;
      });
    };
    return f;
  }

  ComboItemFactory _createLocCombo(SDLocationRecord r ){
    final f = ComboItemFactory.init( 'Location');

    for(final c in worker.locListByArea(r.Area)){
      final ddi = DropdownMenuItem(
        value: c,
        child: ComboDropDownItemChild(
          f,
          c,
          '$c' == r.Location || (f.initItem==null && r.Location ==null),
        ),
      );

      if (f.initItem == null) {
        f.initItem = ddi;
      }else if ('$c' == r.Location){
        f.initItem = ddi;
      }
      f.dropdownMenuItems.add(ddi);
    }

    if (r.Location==null && f.initItem!=null)
      r.Location = '${f.initItem.value}';

    if (f.dropdownMenuItems.length ==0){

      final c = SDLocList.fromEmpty();
      final temp = DropdownMenuItem(
        child: ComboDropDownItemChild(f, c,true),
      );

      f.dropdownMenuItems.add(temp);
      f.initItem = temp;
    }

    f.onSelectionChanged = (v){
      setState(() {
        r.Location = '$v';
      });
    };
    return f;
  }

  ComboItemFactory _createWOCombo(SDLocationRecord r ){
    final f = ComboItemFactory.init( 'WO');
    f.onComboEditPress = (){
      debugPrint('onComboEditPress');
    };
    for(final c in worker.woListByArea(r.Area)){
      final ddi = DropdownMenuItem(
        value: c,
        child: ComboDropDownItemChild(
          f,
          c,
          '$c' == r.WorkOrderNO || (f.initItem==null && r.WorkOrderNO ==null),
        ),
      );

      if (f.initItem == null) {
        f.initItem = ddi;
      }else if ('$c' == r.WorkOrderNO){
        f.initItem = ddi;
      }
      f.dropdownMenuItems.add(ddi);
    }

    if (f.dropdownMenuItems.length ==0)
    {
      final wo =SDWOList.fromEmpty();
      final temp = DropdownMenuItem(
        child: ComboDropDownItemChild(f,wo,true),
      );

      f.dropdownMenuItems.add(temp);
      f.initItem = temp;
    }

    if (r.WorkOrderNO==null && f.initItem!=null)
      r.WorkOrderNO = '${f.initItem.value}';


    f.onSelectionChanged = (v){
      setState(() {
        r.WorkOrderNO = '$v';
      });
    };


    return f;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final  store = StoreProvider.of<SiteDiaryState>(context);
    worker = store.state.currentSiteDiaryWorker;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ComboItem(_createSubContractorCombo(widget.record)),
                ComboItem(_createAreaCombo(widget.record)),
                ComboItem(_createLocCombo(widget.record)),
                ComboItem(_createWOCombo(widget.record)),
              ],
          ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
