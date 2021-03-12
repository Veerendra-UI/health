import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:flutter/material.dart';

class PopMenu extends StatefulWidget {
  final int initialValue;
  PopMenu({@required this.initialValue});
  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  int number;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text(
            "Dictation",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "Location",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Text(
            "Provider",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
      ],
      icon: Icon(
        Icons.segment,
        color: CustomizedColors.iconColor,
      ),
      offset: Offset(0, 125),
      onSelected: (value) {
        if (value == 1) {
          number = 1;
        } else if (value == 2) {
        } else if (value == 3) {
        } else {}
      },
      initialValue: widget.initialValue,
    );
  }
}
