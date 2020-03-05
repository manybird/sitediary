import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sitediary/datas/sitediary/sitediary_list_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_record_object.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';
import 'package:sitediary/redux/site_diary/state_site_diary.dart';
import 'package:sitediary/ui/sitediary/editor/combo_editor.dart';
import 'package:sitediary/ui/sitediary/editor/text_editor.dart';


class SiteDiaryActivityEdit extends StatefulWidget {
  final SDActivityRecord record;
  SiteDiaryActivityEdit(this.record);
  @override
  _SiteDiaryActivityEditState createState() => _SiteDiaryActivityEditState();
}

class _SiteDiaryActivityEditState extends State<SiteDiaryActivityEdit> with AutomaticKeepAliveClientMixin {

  ComboItemFactory _createTypeOfWorkCombo(SDActivityRecord r ){
    final f = ComboItemFactory.init();

    f.buildDropDownMenuItems(
      worker.typeOfWorkList , r.TypeOfWork,
      dummyItemIfEmpty: SDTypeOfWorkList(),
    );
    f.onSelectionChanged = (v){
      setState(() {
        r.TypeOfWork = '$v';
        r.Activity = null;
      });
    };
    return f;
  }

  ComboItemFactory _createActivityCombo(SDActivityRecord r ){
    final f = ComboItemFactory.init();
    f.maxLine = 5;
    f.onComboEditAdd = (v){
      worker.activityListAdd(v??'',r.TypeOfWork,false);
    };
    worker.activityListAdd(r.Activity,r.TypeOfWork,true);
    f.buildDropDownMenuItems(
      worker.getActivityListByTypeOfWork(r.TypeOfWork,r.Activity) , r.Activity,
      dummyItemIfEmpty: SDActivityList(),
    );
    f.onSelectionChanged = (v){
      setState(() {
        r.Activity = '$v';
      });
    };
    return f;
  }

  SiteDiaryWorker worker;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final  store = StoreProvider.of<SiteDiaryState>(context);
    worker = store.state.currentSiteDiaryWorker;
    final r = widget.record;

    return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[

              TextEditor(
                r.ActivityCode,
                title: 'Activity Code',
                onTextChanged: (v){
                  r.ActivityCode = v;
                  if (v.length > 0){
                    final l =  worker.getActivityListByCode(v);
                    if (l.length >0){
                      final w = l.elementAt(0);
                      r.Activity = w.ListName;
                      r.TypeOfWork = w.TypeOfWork;
                    }
                  }
                  setState(() { });
                },
              ),
              ComboEditor(_createTypeOfWorkCombo(r),title: 'Type of work'),
              ComboEditor(_createActivityCombo(r),title: 'Activity'),
              TextEditor(
                r.WorkOrderNo, title: 'Work Order No',
                onTextChanged: (v){
                  setState(() => r.WorkOrderNo = v);
                },
              ),
              TextEditor(
                r.SubActivity, title: 'SubActivity',
                onTextChanged: (v)=> setState(() => r.SubActivity = v),
              ),
              TextEditor(
                r.Description, title: 'Description',
                onTextChanged: (v)=> setState(() => r.Description = v),
              ),
              TextEditor(
                r.Attachments, title: 'Attachment',
                onTextChanged: (v)=> setState(() => r.Attachments = v),
              ),
              TextEditor(
                r.Remarks, title: 'Remarks',
                onTextChanged: (v)=> setState(() => r.Remarks = v),
              ),
            ],
          ),
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
