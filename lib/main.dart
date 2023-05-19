import 'package:cdio/Calendar.dart';
import 'package:cdio/Settings.dart';
import 'package:cdio/Task.dart';
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

    runApp(MaterialApp(home: MRegister(),debugShowCheckedModeBanner: false,));

}

class Mytodolist extends StatefulWidget {
  String uid;
   Mytodolist({Key? key,required this.uid}) : super(key: key);

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

class MRegister extends StatefulWidget {
  const MRegister({Key? key}) : super(key: key);

  @override
  State<MRegister> createState() => _MRegisterState();
}

class _MRegisterState extends State<MRegister> {
  final memail_contro = TextEditingController();
  final mpass_confirm = TextEditingController();
  final mpass = TextEditingController();
  late  bool er_visible = false;
  late  String text_error_register ="ư";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  'Welcome to PLANPRO! ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 40),
                child: Text('Let’s help to meet up your tasks.',
                    style: TextStyle(fontSize: 13, color: Colors.black)),
              ),
              _buildTextField('Enter your Email', memail_contro),
              _buildTextField('Enter Password', mpass),
              _buildTextField('Confirm password', mpass_confirm),
              Padding(
                padding:
                EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(MColor.blue_main),
                      ),
                      onPressed: () async {
                        if (mpass.text == mpass_confirm.text) {
                          try {
                            UserCredential  credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: memail_contro.text,
                              password: mpass.text,
                            );
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final User? user = auth.currentUser;
                            final uid = user?.uid;
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Mytodolist(uid: uid.toString(),)),);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                              setState(() {
                                er_visible = true;
                                text_error_register='The password provided is too weak.';
                                print('The password provided is too weak.');
                              });

                            } else if (e.code == 'email-already-in-use') {
                              setState(() {
                                er_visible = true;
                                text_error_register ='The account already exists for that email.';
                              });
                            }else{
                              text_error_register = "Error from system";
                            }

                          } catch (e) {
                            er_visible = true;
                          }
                        }else{
                          setState(() {
                            er_visible = true;
                          });
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: TextButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Already have an account ?',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          'Sign In',
                          style: TextStyle(color: MColor.blue_main, fontSize: 16),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Visibility(
                visible: er_visible,
                child: Text(text_error_register,style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(String text, TextEditingController mcontrol) {
  return Padding(
    padding: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
    child: TextField(
      controller: mcontrol,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(100))),
          hintText: text,
          hintStyle: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
    ),
  );
}
class Bird extends StatefulWidget {
  const Bird({
    super.key,
    this.color = const Color(0xFFFFE306),
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  double _size = 1.0;
  void grow() {
    setState(() { _size += 0.1; });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      child: widget.child,
    );
  }
}
