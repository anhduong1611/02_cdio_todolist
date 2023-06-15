import 'package:cdio/Screen/update_screen.dart';
import 'package:cdio/Todolist_Color.dart';
import 'package:cdio/database/FireBaseOptions.dart';
import 'package:cdio/wigdet/AlerDialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../OTask.dart';

class ItemsView extends StatefulWidget {
  final Task_todo task;
  int color;
  ItemsView({Key? key, required this.task, required this.color})
      : super(key: key);

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

enum Complete { task_complete }

class _ItemsViewState extends State<ItemsView> {
  FireBaseOptions option = FireBaseOptions();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return MColor.blue_main;
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    String formattedDate = this.widget.task.duedate != ""
        ? DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(this.widget.task.duedate.toString())))
        : "";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(

        children: [

          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                color: (this.widget.task.completed) as bool ? MColor.grey_completed_background : (this.widget.color % 2 == 0 ? MColor.blue_op : Colors.white),

                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 25,
                  height: 60,
                  decoration: BoxDecoration(
                      color: setColor(this.widget.task.type.toString()),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(110),bottomLeft: Radius.circular(110))
                    ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment:AlignmentDirectional.centerStart,
                              child: Text(
                                this.widget.task.name.toString(),
                                maxLines: 1,
                                style: TextStyle(fontSize: 13,
                                color: (this.widget.task.completed) as bool ? MColor.grey_text_completed:Colors.black),
                              ),
                            ),
                            Container(
                              child: Divider(
                                  height: 5,
                                  thickness: 1,
                                  color:(this.widget.task.completed) as bool ? MColor.grey_text_completed:Colors.transparent),
                            ),
                          ],
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 10, color:(this.widget.task.completed) as bool ? MColor.grey_text_duedate_completed: MColor.red_main),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          side:
                          BorderSide(color: Colors.transparent),
                          activeColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: this.widget.task.completed,
                          onChanged: (bool? value) {
                            setState(() {
                              print('checked' + this.widget.task.id.toString());
                              option.checked_task(
                                  this.widget.task.id.toString(), value!);
                              option.update_state_task(widget.task.id.toString(),this.widget.task.duedate.toString(), value!);
                            });
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: SvgPicture.asset('assets/icons/ic_edit.svg',color: (this.widget.task.completed) as bool ? MColor.grey_text_duedate_completed:MColor.blue_main,),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MUpdateScreen(
                                        task_todo: this.widget.task,
                                      )));
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          MAlerDialog alert = MAlerDialog();
                          alert.Alert_delete(context, this.widget.task.id.toString());
                        },
                        child: SvgPicture.asset('assets/icons/ic_bin.svg',color: (this.widget.task.completed) as bool ? MColor.grey_text_duedate_completed:MColor.red_main,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
  setColor(String values){
    if(values == 'No type')
      return this.widget.task.completed as bool == false? (this.widget.color % 2 == 0 ? MColor.blue_op : Colors.white): MColor.grey_completed_background1;
    if(values == 'Important')
      return MColor.red_main;
    if(values == 'Personal')
      return MColor.personal;
    if(values == 'Work')
      return MColor.work;
  }
}

