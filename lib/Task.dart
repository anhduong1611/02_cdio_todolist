import 'package:cdio/OTask.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MTask extends StatefulWidget {
  const MTask({Key? key}) : super(key: key);

  @override
  State<MTask> createState() => _MTaskState();
}

class _MTaskState extends State<MTask> {

  @override
  Widget build(BuildContext context) {
     List<Task_todo> list_task = List.empty();
    list_task.add(new Task_todo("16/11/2002", "Ăn cơm"));
    double screenHeight = MediaQuery.of(context).size.height;
    return  SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          Image.asset(
            'assets/image/shape_top.png',
            height: 160,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/image/empty_task.png')],
            ),
          
          ),

        ],
      ),
    );
  }
}
