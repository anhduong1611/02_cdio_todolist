import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist/task_screen.dart';
//í là lỡ là chung r thì uo lên chung lun i
// dỡ merge splash thấy up r mà
//thoi up chung vs cai lopgin di bỏ nhanh splash cũn d
// dô git chua
void main() async {
  // runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Login_Screen()));
}
//reng main ở trong ni
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
  //Function login
  static Future<User?> loginUsingEmailPassword({required String email,required String password,required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

    }on FirebaseAuthException catch(e) {
      if(e.code == "user-not-found") {
        print('No user found fo that email');
      }
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset('assest/image/shape.png'),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  Image.asset('assest/image/logo_login.png',
                      alignment: Alignment.center),
                  SizedBox(
                    height: 20,
                  ),
                  new Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, top: 60.0, right: 30.0),
                      height: 40.0,
                      decoration: new BoxDecoration(
                          color: Color.fromARGB(255, 237, 233, 233),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.7))),
                      child: new Directionality(
                          textDirection: TextDirection.ltr,
                          child: new TextField(
                            
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            autofocus: false,
                            style: new TextStyle(
                                fontSize: 13.0, color: Colors.black),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .white, //chinh backgroud color cho Text Field
                              hintText: 'Enter your Email',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                            ),
                          ))),
                  new Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, top: 30.0, right: 30.0),
                      height: 40.0,
                      decoration: new BoxDecoration(
                          color: Color.fromARGB(255, 237, 233, 233),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.7))),
                      child: new Directionality(
                          textDirection: TextDirection.ltr,
                          child: new TextField(
                            obscureText: true,
                            obscuringCharacter: "*",
                            controller: _passwordController,
                            autofocus: false,
                            style: new TextStyle(
                                fontSize: 13.0, color: Colors.black),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .white, //chinh backgroud color cho Text Field
                              hintText: 'Enter Password',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(25.7),
                              ),
                            ),
                          ))),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Forget password ?',
                    style: TextStyle(
                        fontSize: 13, color: Color.fromRGBO(80, 194, 201, 1)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  new SizedBox(
                    width: 380.0,
                    height: 60.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(80, 194, 201, 1)),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                        print(user);
                        if(user != null) {
                           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Task_Screen()),
                    );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do not have an account ?',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(80, 194, 201, 1)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
