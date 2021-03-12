import '../../network/services/schedules/appointment_service.dart';
import '../../network/models/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ProviderDropDowns extends StatefulWidget {
  final onTapOfProviders;
  final String selectedProviderId;
  ProviderDropDowns({@required this.onTapOfProviders, this.selectedProviderId});
  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState extends State<ProviderDropDowns> {
  Services apiServices = Services();
  ProviderList providerList;
  List<ProviderList> _list = [];

//getting the data for getProviders
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Providers provider = await apiServices.getProviders();
    _list = provider.providerList;

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
        hint: Text('Select Provider'),
        label: Text(
          'Provider',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        items: _list.map((item) {
          return DropdownMenuItem<ProviderList>(
            child: Text(
              item.displayname,
              overflow: TextOverflow.ellipsis,
            ),
            value: item,
// value: item.providerId.toString(),
          );
        }).toList(),
        isExpanded: true,
        value: providerList,
        searchHint: new Text('Select ', style: new TextStyle(fontSize: 20)),
        onChanged: (value) {
          setState(() {
            providerList = value;
          });

          widget.onTapOfProviders(value);
        },
      ),
    );
  }
}
