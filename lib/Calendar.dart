import 'package:flutter/cupertino.dart';

class MCalendar extends StatefulWidget {
  const MCalendar({Key? key}) : super(key: key);

  @override
  State<MCalendar> createState() => _MCalendarState();
}

class _MCalendarState extends State<MCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Calendar Screen")),
    );
  }
}
