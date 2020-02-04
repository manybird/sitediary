import 'dart:typed_data';
import 'package:sitediary/datas/eform/eform_record.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureDialog2 extends StatefulWidget {
  final List<Point> initPoint;
  final EFormRecordDetail recordDetail;
  SignatureDialog2( this.recordDetail, {this.initPoint});

  @override
  _SignatureDialog2State createState() => _SignatureDialog2State();
}

class _SignatureDialog2State extends State<SignatureDialog2> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      contentPadding: EdgeInsets.all(1),
      content: Builder(
          builder: (BuildContext context){
            return Container(
                child: signature,
              height: 150,
            );
          }
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            return Navigator.of(context).pop(null);
          },
          child: Text('Close'),
        ),
        FlatButton(
          onPressed: (){
            setState(() {
              signature.clear();
            });
          },
          child: Text('Clear'),
        ),
        FlatButton(
          onPressed: () async {
            //final List<Point> list = signature.exportPoints();
            //final  l = List<Offset>();
            //list.forEach((p){ l.add(p.offset); });

            if (signature.isEmpty){
              return Navigator.of(context).pop(Uint8List(0));
            }else{
              Uint8List list = await signature.exportBytes();
              return Navigator.of(context).pop(list);
            }

          },
          child: Text('Save'),
        ),
      ],
    );
  }
Signature signature;
  @override
  void initState() {
    super.initState();
    signature =Signature(
      width: 300,
      height: 200,
      backgroundColor: Colors.lightBlueAccent[100],
    );
  }
}

/// Useless, private it
class _SignatureDialog extends StatefulWidget {

  @override
  _SignatureDialogState createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<_SignatureDialog> {

  List<Offset> points = List() ;

  SignaturePainter customPaint;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(1),

      content: Builder(
        builder: (BuildContext ccc){
          return Container(
            height: 200,
            padding: EdgeInsets.all(0),
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                //_painter.hasChange = true;

                RenderBox object = ccc.findRenderObject();
                Offset _localPosition =
                object.globalToLocal(details.globalPosition);
                //print('onPanUpdate ${details.globalPosition}, $_localPosition');
                setState(() {
                  points = List.from(points)..add(_localPosition);
                });
              },
              onPanEnd: (DragEndDetails details) {
                points = List.from(points)..add(null);
                print('onPanEnd $details , ${points.length}');
              },
              child: CustomPaint(
                painter: SignaturePainter(points),
                size: Size.infinite,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.black54,
              ),
            ),
          );
        }
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            return Navigator.of(context).pop(null);
          },
          child: Text('Close'),
        ),
        FlatButton(
          onPressed: (){
            setState(() {
              points = List();
            });
          },
          child: Text('Clear'),
        ),
        FlatButton(
          onPressed: (){
            return Navigator.of(context).pop(points);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

  }
}

class SignaturePainter extends CustomPainter {
  List<Offset> points;
  SignaturePainter(this.points);


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (int i = 0; i < points.length - 1; i++) {
      final p = points[i];

      if (p != null && points[i + 1] != null) {
        canvas.drawLine(p, points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points!=points;
  }
}