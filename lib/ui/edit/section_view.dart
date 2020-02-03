import 'package:sitediary/datas/eform_item_section.dart';
import 'package:sitediary/ui/edit/record_detail_view.dart';

import 'package:flutter/material.dart';

class SectionView extends StatelessWidget {
  final EFormItemSection _eFormItemSection;
  final bool isActiveSection;
  final bool isAbleToSave;

  final Function onReceived;

  SectionView(this._eFormItemSection, this.isActiveSection, this.isAbleToSave, this.onReceived);
  @override
  Widget build(BuildContext context) {

    final list = List<RecordDetailView>();

    list.insert(0,
        RecordDetailHeaderView( EFormItemSectionDetail(),isActiveSection, isAbleToSave ,_eFormItemSection)
    );

    for(int i=0;i < _eFormItemSection.detailList.length;i++){
      final f = _eFormItemSection.detailList[i];
      //print(f.recordDetail.orderSeq);
      if ((f.recordDetail.orderSeq??0) < 1) continue;
      final v = RecordDetailView(f,this.isActiveSection,this.isAbleToSave, onReceived);
      list.add(v);
    }



    return Container(
      child:  Column(
        //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list
      ),
      decoration:  BoxDecoration(
        border: Border.all(
            color: this.isActiveSection?Colors.red[300]: Colors.lightBlue[200],
            width: this.isActiveSection?4:2
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),

      ),
    );
  }
}

