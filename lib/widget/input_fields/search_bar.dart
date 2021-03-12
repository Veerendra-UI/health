import 'package:flutter/material.dart';

class PatientSerach extends StatelessWidget {
  int width;
  double height;
  final onChanged;
  PatientSerach(
      {@required this.onChanged, @required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        margin: EdgeInsets.only(top: 0.0),
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              trailing: Icon(Icons.search),
              title: new TextField(
                decoration: InputDecoration(hintText: "Search Patients"),
                style: TextStyle(color: Colors.black),
                onChanged: onChanged,
              ),
            )
          ],
        ),
      ),
    );
  }
}
