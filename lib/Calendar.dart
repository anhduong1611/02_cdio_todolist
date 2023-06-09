import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MCalendar extends StatefulWidget {
  const MCalendar({Key? key}) : super(key: key);

  @override
  State<MCalendar> createState() => _MCalendarState();
}

class _MCalendarState extends State<MCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("dadad"),
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton.large(onPressed: (){},child: Icon(Icons.add)),
    );
  }
}
