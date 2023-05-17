import 'package:cdio/Calendar.dart';
import 'package:cdio/Settings.dart';
import 'package:cdio/Task.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:flutter/material.dart';

import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import 'Register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MRegister(),
    MCalendar(),
    MSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColor.grey_background,
      body: Center(
        child: SingleChildScrollView(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: MoltenBottomNavigationBar(
        domeCircleColor: MColor.blue_main,
        selectedIndex: _selectedIndex,
        onTabChange: (clickedIndex) {
          setState(() {
            _selectedIndex = clickedIndex;
          });
        },
        tabs: [
          MoltenTab(
            icon: Icon(Icons.task),
          ),
          MoltenTab(
            icon: Icon(Icons.calendar_month),
          ),
          MoltenTab(
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
