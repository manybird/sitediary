

import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_list_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/ui/sitediary/location/location_main.dart';
import 'package:sitediary/ui/sitediary/location/location_record_list.dart';
import 'package:sitediary/ui/sitediary/recorddate_edit.dart';

import 'combo_item.dart';
class SiteDiaryMainBody extends StatefulWidget {

  final SiteDiaryWorker worker;
  SiteDiaryMainBody(this.worker);

  @override
  _SiteDiaryMainBodyState createState() => _SiteDiaryMainBodyState();
}

class _SiteDiaryMainBodyState extends State<SiteDiaryMainBody> with AutomaticKeepAliveClientMixin {

  ComboItemFactory getStaffListComboItemFactory(String label){
    final ComboItemFactory f = ComboItemFactory(label, dropdownMenuItems: List());

    f.onComboEditPress = (){
      print('onComboEditPress');
    };

    final w = widget.worker;
    for(final c in w.staffList) {
      final ddi = DropdownMenuItem(
        value: c,
        child: ComboDropDownItemChild(
          f,null,
          c==w.selectedUser || (f.initItem==null && w.selectedUser==null),
          itemLabel: c.tText,
        ),
      );

      if (f.initItem == null) {
        f.initItem = ddi;
      }else if (w.selectedUser == c){
        f.initItem = ddi;
      }

      f.dropdownMenuItems.add(ddi);
    }

    if (w.selectedUser==null && f.initItem!=null){
      w.selectedUser= f.initItem.value;
    }

    f.onSelectionChanged = (Object v){
      
      print('onChanged: ${w.selectedUser} => $v');
      setState(() {
        if (w.selectedContract?.isInputStaff ==true){
          w.selectedUser = v;
        }else{
          w.selectedUser = f.initItem.value;
        }

      });
    };

    return f;
  }

  ComboItemFactory getContractCodeComboItemFactory(String label){
    final ComboItemFactory f = ComboItemFactory(label);
    f.title = label;
    final w = widget.worker;
    f.dropdownMenuItems = List();
    for(final c in w.contractCodeList) {
      final ddi = DropdownMenuItem(
        value: c,
        child: ComboDropDownItemChild(
          f, c,
            w.selectedContract ==c || (w.selectedContract==null&& f.initItem==null),

        ),
      );

      if (f.initItem == null) {
        f.initItem = ddi;
      }else if (w.selectedContract == c){
        f.initItem = ddi;
      }

      f.dropdownMenuItems.add(ddi);
    }

    if (w.selectedContract==null && f.initItem!=null){
      //initItem.value = worker.selectedContract;
      w.selectedContract= f.initItem.value;
    }

    f.onSelectionChanged =(Object v){
      print('onChanged:  ${w.selectedContract} => $v, ');
      setState(() {
        if (f.canEdit){
          w.selectedContract = v;
          w.selectedTeam= null;
          w.selectedUser = null;
        }else{
          w.selectedContract = f.initItem.value;
        }

      });
    };

    return f;
  }

  ComboItemFactory getTeamComboItemFactory(String label){
    final ComboItemFactory f = ComboItemFactory(label);
    final w = widget.worker;
    ContractCode selectedContract = w.selectedContract;
    if (selectedContract==null) selectedContract = ContractCode.fromEmpty();

    print('selectedContract: $selectedContract');

    f.dropdownMenuItems = List();

    if (selectedContract.teamList!=null){
      for(final c in selectedContract.teamList) {
        final ddi = DropdownMenuItem(
          value: c,
          child: ComboDropDownItemChild(
            f, c,
              c==w.selectedTeam|| (f.initItem==null && w.selectedTeam==null),
          ),
        );

        if (f.initItem == null) {
          f.initItem = ddi;
        }else if (w.selectedTeam == c){
          f.initItem = ddi;
        }
        f.dropdownMenuItems.add(ddi);
      }
    }
    if (w.selectedTeam==null && f.initItem!=null){
      //initItem.value = w.selectedContract;
      w.selectedTeam= f.initItem.value;
    }

    f.onSelectionChanged =(Object v){
      print('onChanged:  ${w.selectedTeam} => $v ');
      setState(() {
        if (f.canEdit){
          w.selectedTeam = v;
        }else{
          w.selectedTeam = f.initItem.value;
        }
      });
    };

    return f;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ComboItem(getContractCodeComboItemFactory('Contract No:')),
            RecordDateEditor(widget.worker),
            (widget.worker.selectedContract?.isInputStaff == true)? ComboItem(getStaffListComboItemFactory('Input By:')):Container(),
            (widget.worker.selectedContract?.isGroupByTeam == true)? ComboItem(getTeamComboItemFactory('Team:')):Container(),
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Get Data'),
                    onPressed: (){
                       Navigator.pushNamed(context, SiteDiaryLocationMain.router.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
