import 'package:cdio/OTask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Todolist_Color.dart';

class MUpdateScreen extends StatefulWidget {
  Task_todo task_todo;
  MUpdateScreen({Key? key, required this.task_todo}) : super(key: key);

  @override
  State<MUpdateScreen> createState() => _MUpdateScreenState();
}

class _MUpdateScreenState extends State<MUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColor.grey_background,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            alignment: Alignment.topLeft,
            image: AssetImage('assets/image/shape_top.png'),
          )),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 55, bottom: 35),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: null,
                          child: Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                color: MColor.grey_background,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                child: Text(
                                  'No type',
                                  style: TextStyle(color: MColor.grey_text),
                                ),
                              ))),
                      InkWell(
                        onTap: (){

                        },
                        child: Icon(
                          Icons.check_circle,
                          color: MColor.blue_main,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    child: TextField(
                        maxLines: 8,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: this.widget.task_todo.name,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        )),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(

                    children: [
                      InkWell(
                        child: Icon(
                          Icons.calendar_month_rounded,
                          color: MColor.blue_main,
                          size: 35,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Text('Due Date'),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Container(
                            decoration: BoxDecoration(
                              color: MColor.duedate,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  this.widget.task_todo.duedate =="" ?"No Due": DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(this.widget.task_todo.date.toString()))),
                                  style: TextStyle(color: MColor.red_main),
                                ),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
