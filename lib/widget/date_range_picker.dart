import 'dart:math';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/raised_buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateFilter extends StatefulWidget {
  @override
  DateFilterState createState() => DateFilterState();
}

class DateFilterState extends State<DateFilter> {
  String range;
  String _selectedDate;
  String _dateCount;
  String _rangeCount;
  String startDate;
  String endDate;
  Object dateRange = [];
  @override
  void initState() {
    range = '';
// print(_range);
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      try {
        if (args.value is PickerDateRange) {
          startDate = AppConstants.parseDate(-1, AppConstants.MMDDYYYY,
              dateTime: args.value.startDate);
          endDate = AppConstants.parseDate(-1, AppConstants.MMDDYYYY,
              dateTime: args.value.endDate ?? args.value.startDate);
          print("startDate" + startDate);
          print("endDate" + endDate);
          range =
              DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                  ' - ' +
                  DateFormat('dd/MM/yyyy')
                      .format(args.value.endDate ?? args.value.startDate)
                      .toString();
          var obj = [startDate, endDate];
          dateRange = obj;
          print(dateRange);
        } else if (args.value is DateTime) {
          _selectedDate = args.value;
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      } catch (e) {
        print(e);
      }
    });
    print(range);
  }

  Widget potrait({double height1}) {
    return container(height1);
  }

  Widget landScape({double height1}) {
    return container(height1);
  }

  Container container(double height1) {
    return Container(
// color: Colors.green,
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                color: CustomizedColors.accentColor,
                child: Text(
                  "Calendar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomizedColors.textColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Text(
                    'Selected Dates: ' + range,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
              Container(
                height: height1,
                child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      blackoutDates: List<DateTime>()
                        ..add(DateTime(2020, 03, 26)),
                      weekendDays: List<int>()..add(7)..add(6),
                      specialDates: List<DateTime>()
                        ..add(DateTime(2020, 03, 20))
                        ..add(DateTime(2020, 03, 16))
                        ..add(DateTime(2020, 03, 17)),
                      showTrailingAndLeadingDates: true),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    // blackoutDatesDecoration: BoxDecoration(

                    // color: Colors.red,

                    // border: Border.all(color: const Color(0xFFF44436), width: 1),

                    // shape: BoxShape.circle),

                    weekendDatesDecoration: BoxDecoration(
                        color: const Color(0xFFDFDFDF),
                        border: Border.all(
                            color: const Color(0xFFB6B6B6), width: 1),
                        shape: BoxShape.circle),

                    // specialDatesDecoration: BoxDecoration(

                    // color: Colors.green,

                    // border: Border.all(color: const Color(0xFF2B732F), width: 1),

                    // shape: BoxShape.circle),

                    // blackoutDateTextStyle: TextStyle(color: Colors.white, decoration: TextDecoration.lineThrough),

                    // specialDatesTextStyle: const TextStyle(color: Colors.white),
                  ),
                  navigationDirection:
                      DateRangePickerNavigationDirection.vertical,
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  selectionColor: Colors.purple,
                  startRangeSelectionColor: CustomizedColors.accentColor,
                  endRangeSelectionColor: CustomizedColors.accentColor,
                  todayHighlightColor: CustomizedColors.accentColor,
                  initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 4)),
                      DateTime.now().add(const Duration(days: 3))),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.040,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButtons(
                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  RaisedButtons(
                      text: "Ok",
                      onPressed: () {
                        Navigator.pop(context, dateRange);
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return potrait(height1: height * 0.60);
            } else {
              return landScape(height1: height * 0.70);
            }
          },
        ),
      ),
    );
  }
}
