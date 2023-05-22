import 'package:cdio/Calendar.dart';
import 'package:cdio/Settings.dart';
import 'package:cdio/Task.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,// navigation bar color
    statusBarColor: Colors.transparent,
     statusBarBrightness: Brightness.dark,
     statusBarIconBrightness: Brightness.dark,
     // status bar color
  ));
  runApp(MaterialApp(
    home: Mytodolist(
      uid: 'q',
    ),
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
  // List
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MColor.grey_background,
      body: Scaffold(
        body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image/shape_top.png"),
                  alignment: Alignment.topLeft,
                  fit: BoxFit.none),
            ),
            child: _widgetOptions.elementAt(_selectedIndex)),
      ),

      //floatingActionButton: FloatingActionButton.large(onPressed: (){},child: Icon(Icons.add,size: 40,),backgroundColor: MColor.blue_main,),
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
