
import 'package:cdio/Todolist_Color.dart';
import 'package:flutter/material.dart';

class MRegister extends StatefulWidget {
  const MRegister({Key? key}) : super(key: key);

  @override
  State<MRegister> createState() => _MRegisterState();
}

class _MRegisterState extends State<MRegister> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text('Welcome to PLANPRO! ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: Text('Let’s help to meet up your tasks.',style: TextStyle(fontSize: 13,color: Colors.black)),
            ),
            _buildTextField('Enter your full name'),
            _buildTextField('Enter your Email'),
            _buildTextField('Enter Password'),
            _buildTextField('Confirm password'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MColor.blue_main
              ),
                onPressed: null, child: Text('Register'))
          ],
        ),
      ),
    );
  }
}


Widget _buildTextField(String text){
  
  return Padding(
    padding: EdgeInsets.only(left: 30,top: 10, right: 30, bottom: 10),
    child: TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        hintText: text,
        hintStyle: TextStyle(fontSize: 13, fontFamily: 'Poppins')
      ),
    ),
  );
}