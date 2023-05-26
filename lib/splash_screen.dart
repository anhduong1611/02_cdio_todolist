import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cdio/login_screen.dart';

import 'Register.dart';
import 'main.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 230, 243, 246),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/image/shape.png'),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset('assets/image/logo_login.png',
                    alignment: Alignment.center),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: new Container(
                  child: Text(
                    'Gets things with PLANPRO',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              new SizedBox(
                width: 380.0,
                height: 60.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(80, 194, 201, 1)),
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    check(context);
                  },
                ),
              ),
            ],
          )
          // Container(color: Colors.amber,)
        ],
      ),
    );
  }
}

void check(BuildContext context) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MRegister()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Mytodolist(
                  uid: user.uid,
                )),
      );
    }
  });
}
