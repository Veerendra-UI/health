import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:flutter/material.dart';

//stateless Widget for Common Raised Button
class RaisedButtons extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  RaisedButtons({@required this.text, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: CustomizedColors.signInButtonColor,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        padding: EdgeInsets.all(18.0),
        child: Text(
          text,
          style: TextStyle(
              color: CustomizedColors.signInButtonTextColor, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
