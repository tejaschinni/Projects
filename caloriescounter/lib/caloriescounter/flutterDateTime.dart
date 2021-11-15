import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';

class FlutterDateTimeDemo extends StatefulWidget {
  DateTime date;
  Function selectedDate;
  FlutterDateTimeDemo(this.date, this.selectedDate);

  @override
  _FlutterDateTimeDemoState createState() => _FlutterDateTimeDemoState();
}

class _FlutterDateTimeDemoState extends State<FlutterDateTimeDemo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(' Start Date ' + widget.date.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              padding: const EdgeInsets.only(top: 11, bottom: 11),
              decoration: BoxDecoration(color: const Color(0xFFF5F5F5)),
              child: FlutterDatePickerTimeline(
                startDate: widget.date,
                endDate: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
                initialSelectedDate: DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day),
                onSelectedDateChange: (dateTime) {
                  print('selected Date' + dateTime.toString());
                  widget.selectedDate(dateTime);
                },
              )),
        ));
  }
}
