import 'package:flutter/material.dart';
import 'package:todolist/login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splash_screen(),
  ));
}

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 230, 243, 246),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assest/image/shape.png'),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset('assest/image/Logo.png',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login_Screen()),
                    );
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
