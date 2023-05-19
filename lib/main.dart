import 'package:cdio/Calendar.dart';
import 'package:cdio/Settings.dart';
import 'package:cdio/Task.dart';
import 'package:cdio/login_screen.dart';
import 'package:cdio/splash_screen.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:cdio/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import 'Register.dart';

late bool check_user;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    home: splash_screen(),
    debugShowCheckedModeBanner: false,
  ));
}

class Mytodolist extends StatefulWidget {
  String uid;
  Mytodolist({Key? key, required this.uid}) : super(key: key);

  @override
  State<Mytodolist> createState() => _MytodolistState();
}

class _MytodolistState extends State<Mytodolist> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MTask(),
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


































