import 'package:flutter/material.dart';

//stateless Widget for Common DropDown Button
class DropDown extends StatelessWidget {
  final String hint;

  final String value;
  final Function(String) onChanged;
  final items;
  DropDown(
      {@required this.hint,
      @required this.value,
      @required this.onChanged,
      @required this.items});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          hint: Text(hint),
          value: value,
          isExpanded: true,
          isDense: true,
          onChanged: onChanged,
          items: items),
    );
  }
}
