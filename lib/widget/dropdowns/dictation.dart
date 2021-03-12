import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../../network/models/home/dictation.dart';

class Dictation extends StatefulWidget {
  final onTapOfDictation;
  Dictation({@required this.onTapOfDictation});

  @override
  _DictationSearchState createState() => _DictationSearchState();
}

class _DictationSearchState extends State<Dictation> {
  bool searching = false;
  DictationStatus _currentSelectedValue;
  final String url = "https://jsonplaceholder.typicode.com/users";

  List<DictationStatus> data = List(); //edited line

//get dictation method from json
  Future<String> getDictation() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/appointment.json");
    final jsonResult = json.decode(jsonData);
    data = List<DictationStatus>.from(
        jsonResult.map((x) => DictationStatus.fromJson(x)));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.getDictation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      width: 320,
      child: SearchableDropdown.single(
        displayClearIcon: false,
        hint: Text('Select Dictation'),
        label: Text(
          ' Dictation',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        items: data.map((item) {
          print('item $item');
          return DropdownMenuItem<DictationStatus>(
            child: new Text(item.dictationstatus),
            value: item,
          );
        }).toList(),
        value: _currentSelectedValue,
        isExpanded: true,
        searchHint: new Text('Select ', style: new TextStyle(fontSize: 20)),
        onChanged: (value) {
          print('value $value');
          setState(
            () {
              _currentSelectedValue = value;
            },
          );
          widget.onTapOfDictation(value);
        },
      ),
    );
  }
}
