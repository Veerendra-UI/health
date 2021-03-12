import '../../network/services/schedules/appointment_service.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../../network/models/home/location.dart';

class LocationDropDown extends StatefulWidget {
  final onTapOfLocation;
  final String selectedLocationId;
  LocationDropDown({@required this.onTapOfLocation, this.selectedLocationId});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationDropDown> {
  Services apiServices = Services();
  LocationList locationList;
  List<LocationList> _list = [];

//getting the location list from apiServices
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Locations location = await apiServices.getLocation();
    _list = location.locationList;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      width: 320,
      child: SearchableDropdown.single(
        displayClearIcon: false,
        hint: Text('Select Location'),
        label: Text(
          'Location',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        items: _list.map((item) {
          return DropdownMenuItem<LocationList>(
              child: Text(
                item.locationName,
                overflow: TextOverflow.ellipsis,
              ),
              value: item);
        }).toList(),
        isExpanded: true,
        value: locationList,
        searchHint: new Text('Select ', style: new TextStyle(fontSize: 20)),
        onChanged: (value) {
          setState(() {
            locationList = value;
          });

          widget.onTapOfLocation(value);
        },
      ),
    );
  }
}
