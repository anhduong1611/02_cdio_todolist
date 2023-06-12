import 'package:cdio/Calendar.dart';
import 'package:cdio/Settings.dart';
import 'package:cdio/Task.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:cdio/database/FireBaseOptions.dart';
import 'package:cdio/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,// navigation bar color
    statusBarColor: Colors.transparent,
     statusBarBrightness: Brightness.dark,
     statusBarIconBrightness: Brightness.dark,
     // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(

    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color.fromARGB(253, 230, 243, 246),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (FirebaseAuth.instance.currentUser == null) {
            return login_screen();
          }
          return  Center(
            child: Mytodolist(uid: FirebaseAuth.instance.currentUser!.uid.toString()),
          );
        },
      ),
    );
  }
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
      body:   Container(
        width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topLeft,
              image: AssetImage('assets/image/shape_top.png'),
            )
          ),
          child: Container(child: _widgetOptions.elementAt(_selectedIndex))),

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

