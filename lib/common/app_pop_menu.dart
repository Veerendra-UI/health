import 'package:flutter/material.dart';

class Pop extends StatefulWidget {
  final int initialValue;
  Pop({@required this.initialValue});

  @override
  _PopState createState() => _PopState();
}

class _PopState extends State<Pop> {
  int number;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text(
            "Manual Dictation",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "External Attachment",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Text(
            "Quick Appointment",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Text(
            "Quick Prescription",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
      ],
      icon: Icon(Icons.add),
      offset: Offset(0, -425),
      onSelected: (value) {
        if (value == 1) {
          // setState(() {
          //   number = value;
          // });

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ManualDictation(value),
          //   ),
          // );
          number = 1;
        } else if (value == 2) {
          // setState(() {
          //   number = value;
          // });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ChildWidget(value),
          //   ),
          // );
        } else if (value == 3) {
          // setState(() {
          //   number = value;
          // });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ShowModalBottomSheet(value),
          //   ),
          // );
        } else {
          // setState(() {
          //   number = value;
          // });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Flutter4(value),
          //   ),
          // );
        }

        // setState(() {
        //   number = value;
        // });
      },
      initialValue: widget.initialValue,
    );
  }
}
