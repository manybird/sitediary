import 'package:flutter/material.dart';
import 'package:sitediary/datas/sitediary/sitediary_worker.dart';

class RecordDateEditor extends StatefulWidget {

  final SiteDiaryWorker siteDiaryWorker;
  RecordDateEditor(this.siteDiaryWorker);

  @override
  _DateEditorState createState() => _DateEditorState();
}

class _DateEditorState extends State<RecordDateEditor> {


  _selectDateAndTime( BuildContext context, DateTime sd, bool dateOnly) async {

    if (sd==null) sd = DateTime.now();

    DateTime v = await showDatePicker(context: context,
      initialDate: DateTime(sd.year, sd.month, sd.day),
      firstDate: DateTime(sd.year - 30),
      lastDate: DateTime(sd.year + 30),);

    if (v == null) return;

    if (!dateOnly){
      final TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: sd.hour, minute: sd.minute,),
      );

      if (t == null) return;
      v = v.add(Duration(hours: t.hour));
      v = v.add(Duration(minutes: t.minute));
    }

    setState(() {
      widget.siteDiaryWorker.RecordDate = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Recrod Date:'),
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: (){
              _selectDateAndTime(context, widget.siteDiaryWorker.RecordDate, true);
            },
            child: Container(
              padding: EdgeInsets.only(top: 1, left: 8),
              margin: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width ,
              child: Text(
                '${widget.siteDiaryWorker.getRecordDateString}', style: Theme
                    .of(context)
                    .textTheme
                    .subtitle,),
              decoration:   BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey)
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
