import 'package:cdio/Todolist_Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';
void main() async {
  // runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Login_Screen()));
}
class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  //init firebase 
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 230, 243, 246),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return login_screen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {

  //google gmail

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;
    double screenWidth = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/shape_top.png'),
          alignment: Alignment.topLeft,
        )
      ),
      child:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: screenWidth/12,
              ),
              Image.asset('assets/image/logo_login.png',
                  width: screenHeight*4/5,
                  alignment: Alignment.center),
              SizedBox(
                height: screenWidth/12,
              ),
              new SizedBox(
                width: screenHeight/2,
                height: 60.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: MColor.blue_main),
                  child: Text(
                    'Login by Google',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    await signInWithGoogle();
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  Mytodolist(uid: FirebaseAuth.instance.currentUser!.uid.toString(),),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          )
        )
      );
  }
}
